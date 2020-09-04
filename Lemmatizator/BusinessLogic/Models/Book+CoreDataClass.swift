//
//  Book+CoreDataClass.swift
//  Lemmatizator
//
//  Created by Kamol Ibragimov on 19/08/2020.
//  Copyright © 2020 g00dm0us3. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Book)
public class Book: NSManagedObject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Book> {
        return NSFetchRequest<Book>(entityName: "Book")
    }

    @NSManaged public var title: String?
    @NSManaged public var maxWord: String?
    @NSManaged public var minWord: String?
    @NSManaged public var medianWord: String?
    @NSManaged public var word: Set<Word>?
}

// MARK: Generated accessors for word
extension Book {

    @objc(addWordObject:)
    @NSManaged public func addToWord(_ value: Word)

    @objc(removeWordObject:)
    @NSManaged public func removeFromWord(_ value: Word)

    @objc(addWord:)
    @NSManaged public func addToWord(_ values: NSSet)

    @objc(removeWord:)
    @NSManaged public func removeFromWord(_ values: NSSet)

}
