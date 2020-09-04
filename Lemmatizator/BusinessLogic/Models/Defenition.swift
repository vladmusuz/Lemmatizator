//
//  Defenition.swift
//  Lemmatizator
//
//  Created by Komol Ibragimov on 01/09/2020.
//  Copyright © 2020 g00dm0us3. All rights reserved.
//

import Foundation

struct Defenition: Codable {
    let def: [Defenitions]
}

struct Defenitions: Codable {
    let pos: String
    let tr: [Meanings]
}

struct Meanings: Codable {
    let syn: [Synonyms]?
}

struct Synonyms: Codable {
    let text: String
}
