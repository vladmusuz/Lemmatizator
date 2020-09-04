//
//  Word+CoreDataClass.swift
//  Lemmatizator
//
//  Created by Kamol Ibragimov on 18/08/2020.
//  Copyright © 2020 g00dm0us3. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Word)
public class Word: NSManagedObject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Word> {
        return NSFetchRequest<Word>(entityName: "Word")
    }

    @NSManaged public var defenition: String?
    @NSManaged public var frequence: Int64
    @NSManaged public var name: String?
    @NSManaged public var book: Book?
}
