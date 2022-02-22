//
//  APIResource.swift
//  Movies
//
//  Created by Jithin on 21/02/22.
//

import Foundation

protocol APIResource {

    associatedtype Response: Codable
    var urlString: String {get}
    var URL: URL? {get}
}

extension APIResource {
    var URL: URL? {
        if !urlString.isEmpty {
            if let components = URLComponents(string: urlString) {
                return components.url
            }
        }
        return nil
    }
}
