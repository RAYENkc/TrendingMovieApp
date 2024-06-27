//
//  API.swift
//  TrendingMoviesApp
//
//  Created by Mac Cooperation on 26/6/2024.
//

import Foundation

class NetworkManager {
    let apiKey = "c9856d0cb57c3f14bf75bdc6c063b8f3"
    let baseURL = "https://api.themoviedb.org/3"
    
     init() {}
    
    func fetchTrendingMovies() async throws ->  [Movie] {
        let urlString = "\(baseURL)/discover/movie?api_key=\(apiKey)"
        let url = URL(string: urlString)!
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        var request = URLRequest(url: components.url!)

        
        let (data, _) = try await URLSession.shared.data(for: request)
     //   print(String(decoding: data, as: UTF8.self))
       
        let decode = try JSONDecoder().decode(MoviesResponse.self, from: data)
      
        return decode.results

    }
    
    func fetchMoviesDetails(movieId: Int) async throws ->  MovieDetails {
        let urlDetail = "https://api.themoviedb.org/3/movie/\(movieId)?api_key=\(apiKey)"
        let url = URL(string: urlDetail)!
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        var request = URLRequest(url: components.url!)
        let (data, _) = try await URLSession.shared.data(for: request)
       // print(String(decoding: data, as: UTF8.self))
        let decode = try JSONDecoder().decode(MovieDetails.self, from: data)
     //   print(decode)
        return decode
    }
    
}


