//
//  Endpoint.swift
//  Lemmatizator
//
//  Created by Komol Ibragimov on 01/09/2020.
//  Copyright © 2020 g00dm0us3. All rights reserved.
//

import Foundation

typealias Parameters = [String: Any]

enum ParameterEncoding {
    case URLEncoding, JSONEncoding
}

protocol Endpoint {
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: Parameters? { get }
    var headers: [String: Any] { get }
    var parameterEncoding: ParameterEncoding { get }
}

extension Endpoint {
    var url: URL {
        baseURL.appendingPathComponent(path)
    }
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}
