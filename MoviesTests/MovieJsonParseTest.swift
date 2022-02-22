//
//  MovieDBJsonParseTest.swift
//  MoviesTests
//
//  Created by Jithin on 23/02/22.
//

import XCTest
@testable import Movies

class MovieJsonParseTest: XCTestCase {

    func testCanParseGifts() throws {
                let bundle = Bundle(for: type(of: self))
                guard let json = bundle.url(forResource: "movie", withExtension: "json") else {
                    XCTFail("Missing file: movie.json")
                    return
                }
                let jsonData = try Data(contentsOf: json)
                let movies = try JSONDecoder().decode(Movies.self, from: jsonData)

                XCTAssertNotNil(movies)
                XCTAssertNotNil(movies.page)
                XCTAssertNotNil(movies.results)
                XCTAssertGreaterThan(movies.results?.count ?? 0, 0)
            }
}
