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
    
    case getListOfTopItems
    
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
