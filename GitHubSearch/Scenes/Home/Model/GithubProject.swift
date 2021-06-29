//
//  GithubModel.swift
//  GitHubSearch
//
//  Created by Taras Serbin on 29.06.2021.
//

import Foundation

struct GithubProject: Decodable {
    let id: Int?
    let name: String?
    let description: String?
    let html_url: String?
    let language: String?
}
