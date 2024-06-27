//
//  MovieTableViewCell.swift
//  TrendingMoviesApp
//
//  Created by Mac Cooperation on 26/6/2024.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    @IBOutlet var movieTitleLabel : UILabel!
    @IBOutlet var movieYearLabel : UILabel!
    @IBOutlet var moviePosterImageView : UIImageView!
    static let identifier = "MovieTableViewCell"
    let baseURLImage = "https://image.tmdb.org/t/p/w500/"


    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    static func nib() -> UINib{
        return UINib(nibName: "MovieTableViewCell", bundle: nil)
    }
    func configure(with model: Movie){
        //
        self.movieTitleLabel.text = model.title
        self.movieYearLabel.text = DateHelper.extractYear(from: model.release_date)
        //
        if let posterPath = model.poster_path {
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
