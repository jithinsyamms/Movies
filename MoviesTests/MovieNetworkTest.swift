//
//  MovieDBNetworkTest.swift
//  MoviesTests
//
//  Created by Jithin on 23/02/22.
//

import XCTest
@testable import Movies

class MovieNetworkTest: XCTestCase {

    var movieResource: MovieResource!
    var movieRequest: MovieRequest<MovieResource>!

    override func setUpWithError() throws {
      movieResource = MovieResource()
      movieRequest = MovieRequest(resource: movieResource)
    }

    override func tearDownWithError() throws {
        movieResource = nil
        movieRequest = nil
    }

    func testNetworkRequestForGiftResponse() {

        let expectation = self.expectation(description: "MovieResponse")
        movieRequest.execute { response in
            XCTAssertNotNil(response)
            switch response {
            case .failure(let error):
                XCTFail("Expected to be a success but got a failure with \(error)")
            case .success(let value):
                XCTAssertNotNil(value)
            }

            expectation.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }

}
