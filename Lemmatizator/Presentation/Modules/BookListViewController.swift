//
//  BooksTableViewController.swift
//  Lemmatizator
//
//  Created by Kamol Ibragimov on 19/08/2020.
//  Copyright © 2020 g00dm0us3. All rights reserved.
//

import UIKit

final class BookListViewController: UITableViewController {
    
    var storageService: StorageServiceProtocol!
    var router: RouterProtocol!
    
    private var books: [Book]? {
        if let books = storageService.retrieveBooks(), !books.isEmpty {
            return books
        } else {
            for book in Books.allCases {
                storageService.createBook(objectType: .book(title: book.rawValue.capitalized))
            }
            return storageService.retrieveBooks()
        }
    }
    
    //MARK: - Life Cycle -

    override func viewDidLoad() {
        super.viewDidLoad()
//        storageService.deleteAll(.book())
//        storageService.deleteAll(.word())
        
        title = "Books"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Texts.CellsID.bookCell)
    }
}

// MARK: - Table view data source

extension BookListViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Texts.CellsID.bookCell, for: indexPath)
        let book = books?[indexPath.row]
        cell.textLabel?.text = book?.title
        return cell
    }
}

// MARK: - Table view delegate -

extension BookListViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let book = books?[indexPath.row]
        router.pushWordListViewController(book)
    }
}
