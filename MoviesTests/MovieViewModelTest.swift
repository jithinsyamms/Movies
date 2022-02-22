//
//  MovieDBViewModelTest.swift
//  MoviesTests
//
//  Created by Jithin on 23/02/22.
//

import XCTest
@testable import Movies

class MovieViewModelTest: XCTestCase, MovieProtocol {

    func moviesDownloaded(movies: [Movie]) {
        XCTAssertNotNil(movieViewModel.movies)
        XCTAssertGreaterThan(movieViewModel.movies.count, 0)
        expectation.fulfill()
    }

    func errorOccured() {
        XCTFail("Fetching Movies failed")
    }


    var expectation: XCTestExpectation!
    var movieViewModel: MovieViewModel!

    override func setUp() {
        expectation = self.expectation(description: "FetchSuccessful")
        movieViewModel = MovieViewModel()
        movieViewModel.movieDelegate = self
    }

    override func tearDown() {
        expectation = nil
        movieViewModel.movieDelegate = nil
        movieViewModel = nil
    }

    func testFetchMovies() {
        movieViewModel.fetchMovies()
        waitForExpectations(timeout: 10, handler: nil)
    }

    

}
