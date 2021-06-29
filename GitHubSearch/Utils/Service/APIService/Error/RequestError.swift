//
//  RequestError.swift
//  GitHubSearch
//
//  Created by Taras Serbin on 29.06.2021.
//

import Foundation

enum GitHubSearchError: String, LocalizedError {
    case unknowError

    var errorDescription: String {
        switch self {
        case .unknowError:
            return "Unknown error"
        }
    }
}

struct RequestErrorResponse: Decodable {
    let errors: [RequestError]?
}

struct RequestError: Decodable, LocalizedError {
    let code: String?
    let message: String?

    var errorDescription: String? {
        return errorString()
    }

    enum CodingKeys: String, CodingKey {
        case code = "code"
        case message
    }

    func errorString() -> String {
        return message ?? GitHubSearchError.unknowError.errorDescription
    }
}
