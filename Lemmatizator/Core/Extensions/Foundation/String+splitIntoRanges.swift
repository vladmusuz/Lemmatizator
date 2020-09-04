//
//  String+splitIntoRanges.swift
//  Lemmatizator
//
//  Created by Kamol Ibragimov on 26/08/2020.
//  Copyright © 2020 g00dm0us3. All rights reserved.
//

import Foundation

extension String {
    
    func components(withLength length: Int) -> [String] {
        return stride(from: 0, to: self.count, by: length).map {
            let start = self.index(self.startIndex, offsetBy: $0)
            let end = self.index(start, offsetBy: length, limitedBy: self.endIndex) ?? self.endIndex
            return String(self[start..<end])
        }
    }
}
