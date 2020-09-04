//
//  RetrieveType.swift
//  Lemmatizator
//
//  Created by Kamol Ibragimov on 19/08/2020.
//  Copyright © 2020 g00dm0us3. All rights reserved.
//

import Foundation

enum ObjectType {
    case word(definition: String = "", name: String = "", frequency: Int = 0)
    case book(title: String = "", minWord: String = "", maxWord: String = "", medianWord: String = "", words: [String: Int] = [:])
}
