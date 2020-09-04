//
//  StorageServicee.swift
//  Lemmatizator
//
//  Created by Kamol Ibragimov on 18/08/2020.
//  Copyright © 2020 g00dm0us3. All rights reserved.
//

import Foundation
import CoreData

protocol StorageServiceProtocol: class {
    func createBook(objectType: ObjectType)
    func retrieveBooks() -> [Book]?
    func retrieveBook(withTitle title: String) -> Book?
    func update(object objectType: ObjectType)
    func deleteAll(_ objectType: ObjectType)
}

final class StorageService {
    
    private lazy var parentContext: NSManagedObjectContext = {
        let container = NSPersistentContainer(name: "Lemmatizator")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container.viewContext
    }()
    
    private lazy var childContext: NSManagedObjectContext = {
        let privateChildContext: NSManagedObjectContext = .init(concurrencyType: .privateQueueConcurrencyType)
        privateChildContext.parent = parentContext
        return privateChildContext
    }()
}

//MARK: - CRUD -

extension StorageService: StorageServiceProtocol {
    
    func createBook(objectType: ObjectType) {
        switch objectType {
        case .book(let title, _, _, _, _):
            childContext.performAndWait {
                let book = Book(context: parentContext)
                book.title = title
            }
        default:
            break
        }
        saveContext(.child)
        saveContext(.main)
    }
    
    func retrieveBooks() -> [Book]? {
        let fetchRequest: NSFetchRequest<Book>
        do {
            fetchRequest = Book.fetchRequest()
            let objects = try parentContext.fetch(fetchRequest)
            return objects
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return nil
    }
    
    func retrieveBook(withTitle title: String = "") -> Book? {
        let fetchRequest: NSFetchRequest<Book> = Book.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "title == %@", title)
        
        do {
            let book = try parentContext.fetch(fetchRequest).first
            return book
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return nil
    }
    
    func update(object objectType: ObjectType) {
        let fetchRequestBook: NSFetchRequest<Book>
        
        switch objectType {
        case .book(let title, _, _, _, let words):
            fetchRequestBook = Book.fetchRequest()
            fetchRequestBook.predicate = NSPredicate(format: "title == %@", title)
            
            let book = try? parentContext.fetch(fetchRequestBook).first
            
            for stem in words {
                let word = Word(context: parentContext)
                word.name = stem.key
                word.frequence = Int64(stem.value)
                word.book = book
                book?.addToWord(word)
            }
        case .word:
            break
        }
        saveContext(.main)
    }
    
    func deleteAll(_ objectType: ObjectType) {
        let fetchRequestWord: NSFetchRequest<Word>
        let fetchRequestBook: NSFetchRequest<Book>
        
        switch objectType {
        case .book:
            fetchRequestBook = Book.fetchRequest()
            let objects = try! parentContext.fetch(fetchRequestBook) // remove force
            for obj in objects {
                parentContext.delete(obj)
            }
        case .word:
            fetchRequestWord = Word.fetchRequest()
            let objects = try! parentContext.fetch(fetchRequestWord) // remove force
            for obj in objects {
                parentContext.delete(obj)
            }
        }
        saveContext(.main)
    }
}

//MARK: - Helpers -

private extension StorageService {
    
    enum Context {
        case main, child
    }

    func saveContext(_ type: Context) {
        /// Allows to save context safely. Made to be called once everywhere in
        /// StorageManager Class. In order to fit DRY principle
        switch type {
        case .child:
            childContext.performAndWait {
                if childContext.hasChanges {
                    do {
                        try childContext.save()
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
        case .main:
            if parentContext.hasChanges {
                do {
                    try parentContext.save()
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
}



