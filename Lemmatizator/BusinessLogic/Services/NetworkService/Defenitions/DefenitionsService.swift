//
//  DefenitionsService.swift
//  Lemmatizator
//
//  Created by Komol Ibragimov on 01/09/2020.
//  Copyright © 2020 g00dm0us3. All rights reserved.
//

import Foundation

protocol DefinitionServiceProtocol: class {
    
    func fetchDefenition(word: String, success: @escaping (Defenition?) -> Void,
                         failure: @escaping (Error) -> Void)
}

final class DefinitionService: NetworkService, DefinitionServiceProtocol {
    
    func fetchDefenition(word: String, success: @escaping (Defenition?) -> Void,
                         failure: @escaping (Error) -> Void) {
        let endpoint: DefinitionEndpoint = .synonym(word: word)
        request(endpoint: endpoint, success: { (response: Defenition) in
            success(response)
        }, failure: { (error) in
            failure(error)
        })
    }
}
