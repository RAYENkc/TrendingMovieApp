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
        movieYearLabel.text = DateHelper.extractYear(from: movie?.releaseDate  ?? "")
        movieoverviewLabel.text = movie?.overview
        
        let url = baseURLImage + (movie?.posterPath ?? "")
        let data = try! Data(contentsOf: URL(string: url)!)
        self.moviePosterImageView.image = UIImage(data: data)

    }
    


}
