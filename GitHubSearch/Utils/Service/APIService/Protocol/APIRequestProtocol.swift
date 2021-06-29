// 
//   APIRequestProtocol.swift
//  GitHubSearch
//
//  Created by Taras Serbin on 29.06.2021.
//

import Foundation

enum EncodingType {
    case url
    case json
    case query
    case http
    case array
}

enum APIRequestType {
    case post
    case get
    case put
    case delete
    case patch
}

protocol APIRequestProtocol {
    associatedtype ResponseType: Decodable
    var type: APIRequestType { get }
    var encodingType: EncodingType { get }
    var endPoint: EndPointProtocol { get }
    var parameters: APIParametersProtocol? { get set }
}
