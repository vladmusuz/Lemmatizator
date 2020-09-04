//
//  NSManagedObject+init.swift
//  Lemmatizator
//
//  Created by Kamol Ibragimov on 21/08/2020.
//  Copyright © 2020 g00dm0us3. All rights reserved.
//

import CoreData

public extension NSManagedObject {
    
    convenience init(context: NSManagedObjectContext) {
        let name = String(describing: type(of: self))
        let entity = NSEntityDescription.entity(forEntityName: name, in: context)!
        self.init(entity: entity, insertInto: context)
    }
}
