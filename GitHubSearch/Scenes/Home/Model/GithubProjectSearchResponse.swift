//
//  RepositorySearchResponse.swift
//  GitHubSearch
//
//  Created by Taras Serbin on 29.06.2021.
//

import Foundation

struct GithubProjectSearchResponse: Decodable {
    let total: Int?
    let isIncomplete: Bool
    let repositories: [GithubProject]?
    
    enum CodingKeys: String, CodingKey {
        case total = "total_count"
        case isIncomplete = "incomplete_results"
        case repositories = "items"
    }
}
