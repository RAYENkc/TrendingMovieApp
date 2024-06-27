
import Foundation

class NetworkManager {
    // API key for accessing The Movie DB API
    let apiKey = "c9856d0cb57c3f14bf75bdc6c063b8f3"
    // Base URL for The Movie DB API
    let baseURL = "https://api.themoviedb.org/3"
    
     init() {}
    
    // Fetch trending movies
    func fetchTrendingMovies() async throws ->  [Movie] {
        
        let urlString = "\(baseURL)/discover/movie?api_key=\(apiKey)"
        let url = URL(string: urlString)!
        
        // Initialize URL components and request
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        var request = URLRequest(url: components.url!)

        // Fetch data using URLSession
        let (data, _) = try await URLSession.shared.data(for: request)
        let decode = try JSONDecoder().decode(MoviesResponse.self, from: data)
      
        return decode.results

    }
    
    // Fetch movie details based on movie ID
    func fetchMoviesDetails(movieId: Int) async throws ->  MovieDetails {
        let urlDetail = "https://api.themoviedb.org/3/movie/\(movieId)?api_key=\(apiKey)"
        let url = URL(string: urlDetail)!
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        var request = URLRequest(url: components.url!)
        let (data, _) = try await URLSession.shared.data(for: request)
        let decode = try JSONDecoder().decode(MovieDetails.self, from: data)
        return decode
    }
    
}


