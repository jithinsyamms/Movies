//
//  MovieResource.swift
//  Movies
//
//  Created by Jithin on 21/02/22.
//

import Foundation

struct MovieResource: APIResource {
    typealias Response = Movies
    var urlString: String {
        "https://api.themoviedb.org/3/search/movie?api_key=7e588fae3312be4835d4fcf73918a95f&query=a%20&page=01"
    }
}
