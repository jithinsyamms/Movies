//
//  MovieDBURLTest.swift
//  MoviesTests
//
//  Created by Jithin on 23/02/22.
//

import XCTest
@testable import Movies

class MovieURLTest: XCTestCase {

    var movieResource: MovieResource!
    var expectedURL: URL!
    override func setUpWithError() throws {
        movieResource = MovieResource()
        expectedURL = URL(string: "https://api.themoviedb.org/3/search/movie?api_key=7e588fae3312be4835d4fcf73918a95f&query=a%20&page=01")
    }

    override func tearDownWithError() throws {
        movieResource = nil
    }

    func testMovieURLIsCorrect() {
        let url = movieResource.URL
        XCTAssertEqual(url, expectedURL, "URL does not match with expected URL")
    }

    
}
