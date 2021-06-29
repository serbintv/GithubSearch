// 
//   APIClientProtocol.swift
//  GitHubSearch
//
//  Created by Taras Serbin on 29.06.2021.
//

import Foundation
import Alamofire
import SVProgressHUD

protocol APIClientProtocol: ProgressHudProtocol {
    func fetch<T: APIRequestProtocol>(request: T,
                                      isShowProgressHud: Bool,
                                      completion: @escaping (T.ResponseType?, _ error: Error?) -> Void)
}

extension APIClientProtocol {

    func fetch<T: APIRequestProtocol>(request: T,
                                      isShowProgressHud: Bool = true,
                                      completion: @escaping (T.ResponseType?, _ error: Error?) -> Void) {

        print(request.endPoint.url?.absoluteString ?? "")
        guard let url = request.endPoint.url else { return }
        if isShowProgressHud {
            show()
        }

        let params = request.parameters?.convertToParameters()
        if params != nil {
            let jsonData = try? JSONSerialization.data(withJSONObject: params!, options: [.prettyPrinted])
            print(String(data: jsonData ?? Data(), encoding: .utf8)!, url.absoluteString, request.type)
        }
        AF.request(url, method: getHTTPMethod(with: request),
                   parameters: params,
                   encoding: getEncoding(with: request),
                   headers: getHeader(with: request)).responseJSON { (callback) in
                    self.handle(request: request,
                                isCloseProgressHud: isShowProgressHud,
                                andCallback: callback,
                                completion: { (items, error)  in
                        completion(items, error)
                    })
                   }
    }
}

private extension APIClientProtocol {

    func getHeader<T: APIRequestProtocol>(with request: T) -> HTTPHeaders? {
        switch request.endPoint {
        default:
            return ["Accept": "application/vnd.github.v3+json"]
        }
    }

    func getEncoding<T: APIRequestProtocol>(with request: T) -> ParameterEncoding {
        switch request.encodingType {
        case .json: return  JSONEncoding.init(options: .sortedKeys)
        case .url : return  URLEncoding.default
        case .query : return URLEncoding(destination: .queryString)
        case .http: return URLEncoding.httpBody
        case .array: return URLEncoding(destination: .httpBody, arrayEncoding: .brackets, boolEncoding: .numeric)
        }
    }

    func getHTTPMethod<T: APIRequestProtocol>(with request: T) -> HTTPMethod {
        switch request.type {
        case .post: return .post
        case .get: return .get
        case .put: return .put
        case .delete: return .delete
        case .patch: return .patch
        }
    }

    func handle<T: APIRequestProtocol>(request: T,
                                       isCloseProgressHud: Bool,
                                       andCallback callback: AFDataResponse<Any>,
                                       completion: (T.ResponseType?, Error?) -> Void ) {
        if let data = callback.data, let statusCode = callback.response?.statusCode {
            print(request.endPoint.url?.absoluteString ?? "", String(data: data, encoding: .utf8) ?? "")
            let decoder = JSONDecoder()
            switch statusCode {

            case 200...300:
                do {
                    let items = try decoder.decode(T.ResponseType.self, from: data)
                    completion(items, nil)
                } catch let error {
                    completion(nil, error)
                }

            default:
                if request.endPoint is EndPoint,
                   let error = try? decoder.decode(RequestError.self, from: data) {
                    completion(nil, error)
                }
            }

        } else {
            completion(nil, callback.error)
        }
        
        if isCloseProgressHud {
            close()
        }
    }
}
