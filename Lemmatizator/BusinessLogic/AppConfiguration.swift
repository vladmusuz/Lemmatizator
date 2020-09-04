//
//  AppConfiguration.swift
//  Lemmatizator
//
//  Created by Komol Ibragimov on 01/09/2020.
//  Copyright © 2020 g00dm0us3. All rights reserved.
//

import Foundation

enum AppConfiguration {
    
    private enum Paths {
        static let api = "api/"
        static let version = "v1/"
    }
    
    static let serverURL = URL(string: "https://dictionary.yandex.net/\(Paths.api)\(Paths.version)")!
    static let apiKey = "dict.1.1.20200827T093150Z.1301e8a2e9b1fddf.6e49193b0e3b7f85f3bda93e7c7a5e7c6bed8b9f"
}
