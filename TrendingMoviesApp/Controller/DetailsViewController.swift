//
//  DetailsViewController.swift
//  TrendingMoviesApp
//
//  Created by Mac Cooperation on 26/6/2024.
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet var movieTitleLabel : UILabel!
    @IBOutlet var movieYearLabel : UILabel!
    @IBOutlet var movieoverviewLabel : UITextView!
    @IBOutlet var moviePosterImageView : UIImageView!
    static let identifier = "MovieTableViewCell"
    let baseURLImage = "https://image.tmdb.org/t/p/w500/"
    
    var movie : MovieDetails?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieTitleLabel.text = movie?.title
        movieYearLabel.text = "Release Date: \(DateHelper.formatDate(from: movie?.releaseDate  ?? ""))"
        movieoverviewLabel.text = movie?.overview
        
        if let posterPath = movie?.posterPath {
                   loadImage(from: baseURLImage + posterPath) { image in
                       DispatchQueue.main.async {
                           self.moviePosterImageView.image = image
                       }
                   }
               }

    }
    


}
private func loadImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
      guard let url = URL(string: urlString) else {
          completion(nil)
          return
      }
      
      URLSession.shared.dataTask(with: url) { data, response, error in
          if let data = data, let image = UIImage(data: data) {
              completion(image)
          } else {
              completion(nil)
          }
      }.resume()
  }
