// 
//   APIParametersProtocol.swift
//  GitHubSearch
//
//  Created by Taras Serbin on 29.06.2021.
//

import Foundation

protocol APIParametersProtocol: Encodable {
    func convertToParameters() -> [String: Any]
    func createQuery() -> String
}

extension APIParametersProtocol {
    static func empty() -> [String: Any] {
        return [:]
    }

    func createQuery() -> String {
        return ""
    }

    func encode(to encoder: Encoder) throws {

    }
}
