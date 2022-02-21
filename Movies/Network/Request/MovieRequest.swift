//
//  MovieRequest.swift
//  Movies
//
//  Created by Jithin on 21/02/22.
//

import Foundation

struct MovieRequest<Resource: APIResource> {
    let resource: Resource
    init(resource: Resource) {
        self.resource = resource
    }
}

extension MovieRequest: NetworkRequest {

    typealias Response = Resource.Response
    func decode(_ data: Data) -> Response? {
        let decoder = JSONDecoder()
        return try? decoder.decode(Response.self, from: data)
    }
    func execute(withCompletion completion: @escaping (Result<Response?, Error>) -> Void) {
        load(resource: resource, withCompletion: completion)
    }
}
