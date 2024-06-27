import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    @IBOutlet var moviesTable: UITableView!
    @IBOutlet var searchField: UITextField!
    
    var movies: [Movie] = []
    var filteredMovies: [Movie] = []
    var selectedMovie: MovieDetails?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        moviesTable.delegate = self
        moviesTable.dataSource = self
        searchField.delegate = self
        
        moviesTable.register(MovieTableViewCell.nib(), forCellReuseIdentifier: MovieTableViewCell.identifier)
        // Fetch trending movies
        Task {
            do {
                let fetchedMovies = try await NetworkManager().fetchTrendingMovies()
                DispatchQueue.main.async {
                    self.movies = fetchedMovies
                    self.filteredMovies = fetchedMovies
                    self.moviesTable.reloadData()
                }
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    // Update filtered movies as user types
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        let updatedText = (currentText as NSString).replacingCharacters(in: range, with: string)
        filterMovies(with: updatedText)
        return true
    }
    
    func filterMovies(with query: String) {
        if query.isEmpty {
            filteredMovies = movies
        } else {
            filteredMovies = movies.filter { $0.title.lowercased().contains(query.lowercased()) }
        }
        moviesTable.reloadData()
    }
    
    // UITableView Delegate and DataSource methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier, for: indexPath) as! MovieTableViewCell
        cell.configure(with: filteredMovies[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let movieId = filteredMovies[indexPath.row].id
        Task {
            do {
                let movieRsl = try await NetworkManager().fetchMoviesDetails(movieId: movieId)
                DispatchQueue.main.async {
                    self.selectedMovie = movieRsl
                    self.showMovieDetails()
                }
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    // Present detailed view of selected movie
    private func showMovieDetails() {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetailsViewController") as? DetailsViewController,
              let movie = self.selectedMovie else {
            return
        }
        vc.movie = movie
        present(vc, animated: true)
    }
}
