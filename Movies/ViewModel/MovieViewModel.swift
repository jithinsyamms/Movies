//
//  MovieViewModel.swift
//  Movies
//
//  Created by Jithin on 21/02/22.
//

import Foundation

protocol MovieProtocol: AnyObject {
    func moviesDownloaded(movies: [Movie])
    func errorOccured()
}
protocol MovieItemProtocol: AnyObject {
    func movieDataChanged(movie:Movie?)
}

class MovieViewModel {

    var movies: [Movie] = []
    weak var movieDelegate: MovieProtocol?
    weak var movieItemdelegate: MovieItemProtocol?

    func fetchMovies() {
        
        let resource = MovieResource()
        let request = MovieRequest(resource: resource)
        request.execute { result in
            switch result {
            case .success(let result):
                if let movies = result, let movieResults = movies.results {
                    self.movies = movieResults
                    DispatchQueue.main.async {
                        self.movieDelegate?.moviesDownloaded(movies: self.movies)
                    }

                }
            case .failure(_):
                DispatchQueue.main.async {
                    self.movieDelegate?.errorOccured()
                }
            }
        }
    }

    func fetchMovie(movieId:Int) {
        let movie = movies.filter { movie in
            return movie.id == movieId
        }.first
        self.movieItemdelegate?.movieDataChanged(movie: movie)
    }

    func addToWatchlist(movieId: Int, shouldAdd:Bool) {
        if let movie = movies.filter({ movie in
            return movie.id == movieId
        }).first {
            movie.inWatchList = shouldAdd
            self.movieDelegate?.moviesDownloaded(movies: movies)
            self.movieItemdelegate?.movieDataChanged(movie: movie)
        }
    }
}
