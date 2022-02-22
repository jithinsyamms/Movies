//
//  MovieDetailController.swift
//  Movies
//
//  Created by Jithin on 22/02/22.
//

import UIKit

class MovieDetailController: UIViewController {

    @IBOutlet weak var originalTitle: UILabel!

    @IBOutlet weak var movieTitle: UILabel!

    @IBOutlet weak var overview: UILabel!
    @IBOutlet weak var popularity: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var voteCount: UILabel!
    @IBOutlet weak var addToWatchlistButton: UIButton!

    private var movie: Movie?
    var movieId: Int!
    var movieViewModel: MovieViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        setButton()
        movieViewModel?.movieItemdelegate = self
        movieViewModel?.fetchMovie(movieId: movieId)
        setNavBar()
        setMovieDetails()

    }

    func setButton() {
        addToWatchlistButton.layer.cornerRadius = 20
        addToWatchlistButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    }

    func setMovieDetails() {
        guard let movie = movie else {
            return
        }
        originalTitle.text = "Original Title: \(movie.originalTitle)"
        movieTitle.text = "Title: \(movie.title)"
        overview.text = movie.overview
        popularity.text = "Popularity : \(movie.popularity)"
        releaseDate.text = "Release Date: \(movie.releaseDate)"
        voteCount.text = "Vote Count: \(movie.voteCount)"

        if movie.inWatchList {
            addToWatchlistButton.setTitle("Remove From Watchlist", for: .normal)
        } else {
            addToWatchlistButton.setTitle("Add To Watchlist", for: .normal)
        }

    }

    func setNavBar() {
        self.navigationItem.title = movie?.title
        navigationController?.navigationBar.barTintColor = UIColor.systemBlue
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.tintColor = UIColor.white
    }

    @IBAction func addToWatchList(_ sender: Any) {
        if let movie = movie {
            movieViewModel?.addToWatchlist(movieId: movie.id, shouldAdd: !movie.inWatchList)
        }
    }

}

extension MovieDetailController: MovieItemProtocol {
    func movieDataChanged(movie: Movie?) {
        self.movie = movie
        setMovieDetails()
    }
}
