// 
//   EndPointProtocol.swift
//  GitHubSearch
//
//  Created by Taras Serbin on 29.06.2021.
//

import Foundation

protocol EndPointProtocol {
    var url: URL? { get }
}

extension EndPointProtocol {
    var url: String {
        return "https://api.github.com"
    }
}

enum EndPoint: EndPointProtocol {
    var url: URL? {
        return URL(string: url + self.apiPath)
    }

    case searchRepository
    
    var apiPath: String {
        switch self {
        case .searchRepository: return "/search/repositories"
        }
    }
}
