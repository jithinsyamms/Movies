//
//  NetworkRequest.swift
//  Movies
//
//  Created by Jithin on 21/02/22.
//

import Foundation

protocol NetworkRequest {
    associatedtype Response
    func decode(_ data: Data) -> Response?
    func execute(withCompletion completion: @escaping (Result<Response?, Error>) -> Void)
}

extension NetworkRequest {

    func load<Resource: APIResource>( resource: Resource,
                                      withCompletion completion: @escaping (Result<Response?, Error>) -> Void) {
        guard let url = resource.URL else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        let urlRequest = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: urlRequest) {data, _, error in
            guard error == nil else {
                completion(.failure(error!))
                return
            }
            guard let data = data else {
                completion(.failure(NetworkError.serverError))
                return
            }
            guard let result = self.decode(data) else {
                completion(.failure(NetworkError.decodeError))
                return
            }
            DispatchQueue.main.async {
                completion(.success(result))
            }
        }
        task.resume()
    }
}
