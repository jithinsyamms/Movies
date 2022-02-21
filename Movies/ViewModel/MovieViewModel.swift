//
//  MovieViewModel.swift
//  Movies
//
//  Created by Jithin on 21/02/22.
//

import Foundation

protocol MovieProtocol: AnyObject {
    func moviesDownloaded(movies: [Movie])
}

class MovieViewModel {

    var movies: [Movie] = []
    weak var delegate: MovieProtocol?

    func fetchMovies() {
        let resource = MovieResource()
        let request = MovieRequest(resource: resource)
        request.execute { result in
            switch result {
            case .success(let result):
                if let movies = result, let movieResults = movies.results {
                    self.movies = movieResults
                    self.delegate?.moviesDownloaded(movies: self.movies)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    func addToWatchlist(movieId: Int, shouldAdd:Bool) {
        if let movie = movies.filter({ movie in
            return movie.id == movieId
        }).first {
            movie.inWatchList = shouldAdd
            self.delegate?.moviesDownloaded(movies: movies)
        }

    }
}
