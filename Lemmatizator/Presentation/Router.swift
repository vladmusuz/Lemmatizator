//
//  Router.swift
//  Lemmatizator
//
//  Created by Kamol Ibragimov on 19/08/2020.
//  Copyright © 2020 g00dm0us3. All rights reserved.
//

import UIKit.UIViewController

protocol RouterMain {
    var navigationController: UINavigationController? { get set }
    var dependencies: DependenciesProtocol? { get set }
}

protocol RouterProtocol: RouterMain {
    func initialViewController()
    func pushWordListViewController(_ book: Book?)
    func pushBookDetailViewController(_ stats: [String: Int])
    func pushWordDetailViewController(word: Word?)
    func pop()
}

final class Router: RouterProtocol {
    
    var navigationController: UINavigationController?
    var dependencies: DependenciesProtocol?
    
    init(navigationController: UINavigationController, dependencies: DependenciesProtocol) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    func initialViewController() {
        if let navigationController = navigationController  {
            guard let bookListViewController = dependencies?.createBookListViewController(router: self) else {
                return
            }
            navigationController.viewControllers = [bookListViewController]
        }
    }
    
    func pushWordListViewController(_ book: Book?) {
        if let navigationController = navigationController {
            guard let wordListViewController = dependencies?.createWordListViewController(router: self, book: book) else {
                return
            }
            navigationController.pushViewController(wordListViewController, animated: true)
        }
    }
    
    func pushBookDetailViewController(_ stats: [String : Int]) {
        if let navigationController = navigationController {
            guard let bookDetailsViewController = dependencies?.createBookDetailsViewController(stats: stats) else {
                return
            }
            navigationController.pushViewController(bookDetailsViewController, animated: true)
        }
    }
    
    func pushWordDetailViewController(word: Word?) {
       if let navigationController = navigationController {
            guard let wordDetailsViewController = dependencies?.createWordDetailsViewController(word: word) else {
                return
            }
            navigationController.pushViewController(wordDetailsViewController, animated: true)
        }
    }
    
    func pop() {
        if let navigationController = navigationController {
            navigationController.popViewController(animated: true)
        }
    }
}
