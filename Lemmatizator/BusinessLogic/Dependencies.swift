//
//  DependencyInjector.swift
//  Lemmatizator
//
//  Created by Kamol Ibragimov on 19/08/2020.
//  Copyright © 2020 g00dm0us3. All rights reserved.
//

import UIKit.UIViewController

protocol DependenciesProtocol: class  {
    func createBookListViewController(router: RouterProtocol) -> UITableViewController
    func createWordListViewController(router: RouterProtocol, book: Book?) -> UITableViewController
    func createBookDetailsViewController(stats: [String : Int]) -> UIViewController
    func createWordDetailsViewController(word: Word?) -> UITableViewController
}

final class Dependencies: DependenciesProtocol {
    
    func createBookListViewController(router: RouterProtocol) -> UITableViewController {
        let controller = BookListViewController()
        let storageService = StorageService()
        controller.router = router
        controller.storageService = storageService
        return controller
    }
    
    func createWordListViewController(router: RouterProtocol, book: Book?) -> UITableViewController {
        let controller = WordListViewController()
        let storageService = StorageService()
        let lemmatizator = Lemmatizator()
        controller.router = router
        controller.book = book
        controller.lem = lemmatizator
        controller.storageService = storageService
        return controller
    }
    
    func createBookDetailsViewController(stats: [String : Int]) -> UIViewController {
        let controller = BookDetailsViewController()
        controller.stats = stats
        return controller
    }
    
    func createWordDetailsViewController(word: Word?) -> UITableViewController {
        let controller = WordDetailViewController()
//        let definitionService  = DefinitionService()
        controller.word = word
//        controller.definitionService = definitionService
        return controller
    }
}
