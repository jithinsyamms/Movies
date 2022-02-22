//
//  MovieDBAddMovieToWatchList.swift
//  MoviesTests
//
//  Created by Jithin on 23/02/22.
//

import XCTest
@testable import Movies
class AddMovieToWatchListTest: XCTestCase , MovieItemProtocol {

    var movieId = 818647

    func movieDataChanged(movie: Movie?) {
        if let movie = movie {
            XCTAssertEqual(movie.inWatchList, true)
            expectation.fulfill()
        } else {
            XCTFail("Fetching Movie Item failed")
        }
    }

    var expectation: XCTestExpectation!
    var movieViewModel: MovieViewModel!

    override func setUp() {
        expectation = self.expectation(description: "MovieItemFetch")
        movieViewModel = MovieViewModel()
        movieViewModel.movieItemdelegate = self
    }

    override func tearDown() {
        expectation = nil
        movieViewModel.movieItemdelegate = nil
        movieViewModel = nil
    }

    func testFetchMovieItem() throws {
        let bundle = Bundle(for: type(of: self))
        guard let json = bundle.url(forResource: "movie", withExtension: "json") else {
            XCTFail("Missing file: movie.json")
            return
        }
        let jsonData = try Data(contentsOf: json)
        let movies = try JSONDecoder().decode(Movies.self, from: jsonData)

        if let results = movies.results {
            movieViewModel.movies = results
            movieViewModel.addToWatchlist(movieId: movieId, shouldAdd: true)
            waitForExpectations(timeout: 10, handler: nil)
        } else {
            XCTFail("Parsing Movie Json Failed")
        }

    }

}
