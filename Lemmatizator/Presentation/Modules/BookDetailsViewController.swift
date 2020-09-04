//
//  DetailsViewController.swift
//  Lemmatizator
//
//  Created by Kamol Ibragimov on 19/08/2020.
//  Copyright © 2020 g00dm0us3. All rights reserved.
//

import UIKit

final class BookDetailsViewController: UIViewController {

    private var minWord: UILabel = .init(frame: .init(x: 0, y: 0, width: 300, height: 30))
    private var maxWord: UILabel = .init(frame: .init(x: 0, y: 0, width: 300, height: 30))
    private var medianWord: UILabel = .init(frame: .init(x: 0, y: 0, width: 300, height: 30))
    private var numberOfWords: UILabel = .init(frame: .init(x: 0, y: 0, width: 300, height: 30))
    
    var stats: [String: Int] = [:] {
        didSet {
            print("stats set")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        
        minWord.frame.origin = CGPoint(x: 20, y: 100)
        maxWord.frame.origin = CGPoint(x: 20, y: 140)
        medianWord.frame.origin = CGPoint(x: 20, y: 180)
        numberOfWords.frame.origin = CGPoint(x: 20, y: 220)
        
        [minWord, maxWord, medianWord, numberOfWords].forEach(view.addSubview)
        
        // sorted by frequency
        //        let tuples = stats.map{ ($0, $1) }.sorted{ $0.0 < $1.0 }.sorted{ $0.1 < $1.1 } // -todo: not guaranteed to be stable!!!
        //
        //        print("Min word \(tuples.first!.0): \(tuples.first!.1)")
        //        let median = Int(floor(Double(tuples.count) / 2.0))
        //        print("Median word \(tuples[median].0): \(tuples[median].1)")
        //        print("Max word \(tuples.last!.0): \(tuples.last!.1)")
    }
}
