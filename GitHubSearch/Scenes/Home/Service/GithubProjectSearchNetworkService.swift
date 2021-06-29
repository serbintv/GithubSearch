//
//  NetworkService.swift
//  GitHubSearch
//
//  Created by Taras Serbin on 29.06.2021.
//

import Foundation

struct GithubProjectSearchNetworkService: APIClientProtocol {
    func searchRepositories(parameters: APIParametersProtocol,
                          completion: @escaping (Result<GithubProjectSearchResponse, Error>) -> Void) {
        let request = RequestGenerator<GithubProjectSearchResponse>(type: .get,
                                                                 encodingType:.url,
                                                                 endPoint: EndPoint.searchRepository, parameters: parameters)
        fetch(request: request) { (response, error) in
            if let response = response {
                completion(.success(response))
            } else if let error = error {
                completion(.failure(error))
            } else {
                completion(.failure(GitHubSearchError.unknowError))
            }
        }
    }
}
