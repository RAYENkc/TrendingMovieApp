import Foundation

struct MoviesResponse: Decodable  {
    let page: Int
    let results: [Movie]
    let total_pages: Int
    let total_results : Int
  
}
struct Movie: Decodable {
        let adult: Bool
        let backdrop_path: String?
        let genre_ids: [Int]
        let id: Int
        let original_language: String
        let original_title: String
        let overview: String
        let popularity: Double
        let poster_path: String?
        let release_date: String
        let title: String
        let video: Bool
        let vote_average: Double
        let vote_count: Int
   
 

    /*enum CodingKeys: String, CodingKey {
        case id
        case title
        case video
        case adult
        case backdropPath = "backdrop_path"
        case genreIds = "genre_ids"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
        case popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
      
    }*/
}

