
import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {

    @IBOutlet var moviesTable: UITableView!
    var movies: [Movie] = []
    var selectedMovie: MovieDetails?
    private let tableView = UITableView()
    override func viewDidLoad() {
        super.viewDidLoad()
        moviesTable.delegate = self
        moviesTable.dataSource = self
        moviesTable.register(MovieTableViewCell.nib(), forCellReuseIdentifier: MovieTableViewCell.identifier)
    
        Task {
            do {
                let fetchedMovies = try await NetworkManager().fetchTrendingMovies()
                               // Update movies and reload the table view on the main thread
                               DispatchQueue.main.async {
                                   self.movies = fetchedMovies
                                   self.moviesTable.reloadData()
                               }
            }
            catch{
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    // Table of move
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier, for: indexPath) as! MovieTableViewCell
        cell.configure(with: movies[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let movieId = movies[indexPath.row].id
        Task {
            do {
                
                let movieRsl = try await NetworkManager().fetchMoviesDetails(movieId: movieId)
                DispatchQueue.main.async {
                    self.selectedMovie = movieRsl
                    self.showMovieDetails()
                }
          
            }  catch{
                print("Error: \(error.localizedDescription)")
            }
        }
        
   
    }
    
    private func showMovieDetails() {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetailsViewController") as? DetailsViewController,
              let movie = self.selectedMovie else {
            return
        }
        vc.movie = movie
        present(vc, animated: true)
    }
    
}




