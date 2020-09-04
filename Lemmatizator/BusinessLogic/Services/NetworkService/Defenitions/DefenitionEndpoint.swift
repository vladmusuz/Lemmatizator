//
//  DefenitionEndpoint.swift
//  Lemmatizator
//
//  Created by Komol Ibragimov on 01/09/2020.
//  Copyright © 2020 g00dm0us3. All rights reserved.
//

import Foundation

enum DefinitionEndpoint {
    case synonym(word: String)
}

extension DefinitionEndpoint: Endpoint {
    
    var baseURL: URL {
        AppConfiguration.serverURL
    }
    
    var path: String {
        switch self {
        case .synonym( _):
            return "dicservice.json/lookup"
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .synonym(let word):
            return ["key": AppConfiguration.apiKey,
                    "text": "\(word)",
                    "lang": "en-en"]
        }
    }
    
    var method: HTTPMethod {
        .get
    }
    
    var headers: [String : Any] {
        [:]
    }
    
    var parameterEncoding: ParameterEncoding {
        return .URLEncoding
    }
}
