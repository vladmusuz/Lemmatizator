//
//  NSManagedObjectContext+Extension.swift
//  Lemmatizator
//
//  Created by Kamol Ibragimov on 21/08/2020.
//  Copyright © 2020 g00dm0us3. All rights reserved.
//

import CoreData

extension NSManagedObjectContext {

    func saveOrRollback() -> Bool {
        do {
            try save()
            return true
        } catch {
            rollback()
            return false
        }
    }

    func performChanges(block: @escaping () -> ()) {
        perform {
            block()
            _ = self.saveOrRollback()
        }
    }
}
