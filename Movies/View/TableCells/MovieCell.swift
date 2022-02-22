//
//  MovieCell.swift
//  Movies
//
//  Created by Jithin on 22/02/22.
//

import UIKit

class MovieCell: UITableViewCell {

    @IBOutlet weak var rootView: UIView!

    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieOverview: UILabel!
    @IBOutlet weak var movieReleased: UILabel!
    @IBOutlet weak var popularity: UILabel!
    @IBOutlet weak var watchListImage: UIImageView!
    @IBOutlet weak var watchListImageWidth: NSLayoutConstraint!

    override func awakeFromNib() {
        super.awakeFromNib()
        rootView.layer.cornerRadius = 10
        rootView.layer.borderColor = UIColor.lightGray.cgColor
        rootView.layer.borderWidth = 0.5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func setMovie(movie: Movie?) {

        guard let movie = movie else {
          return
        }
        movieTitle.text = movie.title
        movieOverview.text = movie.overview
        movieReleased.text = "Release Date: \(movie.releaseDate)"
        popularity.text = "Popularity: \(movie.popularity)"
        if movie.inWatchList {
            watchListImage.image = UIImage(systemName: "heart.fill")
            watchListImage.tintColor = .systemPink
            watchListImageWidth.constant = 30
        } else {
            watchListImageWidth.constant = 0
        }
    }
}
