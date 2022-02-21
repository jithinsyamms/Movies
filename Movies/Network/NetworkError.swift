//
//  NetworkError.swift
//  Movies
//
//  Created by Jithin on 21/02/22.
//

import Foundation

enum NetworkError: Error {
    case serverError
    case decodeError
    case unknownError
    case invalidURL
}
