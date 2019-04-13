//
//  NetworkLayer.swift
//  RedditTest
//
//  Created by Pavlo Naumenko on 4/11/19.
//  Copyright © 2019 Pavlo Naumenko. All rights reserved.
//

import Foundation
import UIKit

public enum HTTPMethod: String {
    case options = "OPTIONS"
    case get     = "GET"
    case head    = "HEAD"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
    case trace   = "TRACE"
    case connect = "CONNECT"
}

public protocol URLRequestConvertible {
    func asURLRequest() throws -> URLRequest
}

public enum HTTPRequest: URLRequestConvertible {
    public static let baseURLString = "https://www.reddit.com"
    
    case getListOfTopItems(Parameters?)
    
    var method: HTTPMethod {
        switch self {
        case .getListOfTopItems:
            return HTTPMethod.get
        }
    }
    
    var path: String {
        switch self {
        case .getListOfTopItems:
            return "/top.json"
        }
    }
    
    public func asURLRequest() throws -> URLRequest {
        let url = URL(string: HTTPRequest.baseURLString)!
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        
        switch self {
        case .getListOfTopItems(let parameters):
            urlRequest = try URLParameterEncoding().encode(urlRequest, with: parameters)
        }
        return urlRequest
    }
    
    
}

public enum APIRequest {
    static func request<T: Codable>(_ urlRequest: URLRequestConvertible, decodeTo: T.Type, completionHandler: @escaping (Result<T, Error>) -> Void ) {
        let session = URLSession.shared
        let request = try! urlRequest.asURLRequest()
        let task = session.dataTask(with: request) { (data, response, error)  in
            if error == nil {
                let object = try! JSONDecoder().decode(T.self, from: data!)
                completionHandler(.success(object))
            }else {
                completionHandler(.failure(error!))
            }
        }
        task.resume()
    }
}

public typealias Parameters = [String: Any]

public protocol ParameterEncoding {
    func encode(_ urlRequest: URLRequest, with parameters: Parameters?) throws -> URLRequest
}

public struct URLParameterEncoding: ParameterEncoding {
    public func encode(_ urlRequest: URLRequest, with parameters: Parameters?) throws -> URLRequest {
        var request = urlRequest
        if let url = request.url, let parameters = parameters, parameters.count > 0 {
            var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
            urlComponents?.queryItems = parameters.map{URLQueryItem(name: $0, value: "\($1)".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed))}
            request.url = urlComponents?.url
        }
        return request
    }
}
