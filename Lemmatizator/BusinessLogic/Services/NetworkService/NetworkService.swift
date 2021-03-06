//
//  NetworkService.swift
//  Lemmatizator
//
//  Created by Komol Ibragimov on 01/09/2020.
//  Copyright © 2020 g00dm0us3. All rights reserved.
//

import Foundation

typealias Success<T> = (T) -> Void
typealias Failure = (Error) -> Void

final class NetworkService {
    
    func request<Result: Codable>(endpoint: Endpoint,
                                  success: @escaping Success<Result>,
                                  failure: @escaping Failure) {
        var task: URLSessionDataTask?
        switch endpoint.parameterEncoding {
        case .URLEncoding:
            task = urlEncodedRequest(endpoint: endpoint, success: success, failure: failure)
        case .JSONEncoding:
            task = jsonEncodedRequest(endpoint: endpoint, success: success, failure: failure)
        }
        task?.resume()
    }
    
    private func urlEncodedRequest<Result: Codable>(endpoint: Endpoint,
                                                        success: @escaping Success<Result>,
                                                        failure: @escaping Failure) -> URLSessionDataTask? {
        let url = endpoint.url
        let queryItems = endpoint.parameters?.compactMap({ (name, value) -> URLQueryItem? in
            return URLQueryItem(name: name, value: value as? String)
        })
        var urlComponents = URLComponents(string: url.absoluteString)
        urlComponents?.queryItems = queryItems
        
        guard let resultURL = urlComponents?.url else {
            return nil
        }
        
        return URLSession.shared.dataTask(with: resultURL) { (data, response, error) in
            if let error = error {
                failure(error)
            }
            
            guard let data = data else {
                return
            }
            
            do {
                let result: Result = try JSONDecoder().decode(from: data)
                success(result)
            } catch {
                failure(error)
            }
        }
    }
    
    private func jsonEncodedRequest<Result: Codable>(endpoint: Endpoint,
                                                         success: @escaping Success<Result>,
                                                         failure: @escaping Failure) -> URLSessionDataTask? {
        let url = endpoint.url
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        endpoint.headers.forEach { (key, value) in
            if let value = value as? String {
                request.addValue(value, forHTTPHeaderField: key)
            }
        }
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: endpoint.parameters ?? [:],
                                                         options:[]) else {
                                                            return nil
        }
        request.httpBody = httpBody
        
        return URLSession.shared.dataTask(with: request) { (data,response,error) in
            if let response = response {
                print(response)
            }
            guard let data = data else {
                return
            }
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                print(json)
            } catch {
                print(error)
            }
        }
    }
}
