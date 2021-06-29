//
//  RepositorySearchParameters.swift
//  GitHubSearch
//
//  Created by Taras Serbin on 29.06.2021.
//

import Foundation

struct GithubProjectSearchParameters: APIParametersProtocol {
    let name: String
    let page: Int
    let perPage: Int
    
    func convertToParameters() -> [String : Any] {
        return ["q" : "\(name) in:name",
                "page" : page,
                "perPage" : perPage]
    }
}
