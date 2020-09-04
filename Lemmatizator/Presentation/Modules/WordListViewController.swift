//
//  FirstTableViewController.swift
//  Lemmatizator
//
//  Created by Kamol Ibragimov on 18/08/2020.
//  Copyright © 2020 g00dm0us3. All rights reserved.
//

import UIKit

final class WordListViewController: UITableViewController {
    
    var storageService: StorageServiceProtocol!
    var router: RouterProtocol!
    var lem: LemmatizatorProtocol!
    var definitionService: DefinitionServiceProtocol!
    
    private let dispatchGroup = DispatchGroup()
    
    private var stats: [String: Int] = [:]
    private var wordObjects: [Word]?
    private var words: [Word]? = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    var book: Book?
    
    //MARK: - Life cycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Texts.CellsID.first)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(handleAction))
        title = book?.title ?? ""
        
        if !(book?.word?.isEmpty ?? false) {
            words = book?.word?.compactMap{ $0 }.sorted { $0.name! < $1.name! }
        } else {
            DispatchQueue.global().async {
                let limmitedWordsByFrequency = self.prepareWords(for: self.book?.title?.lowercased() ?? "")
                
                self.storageService.update(object: .book(title: self.book?.title ?? "", words: limmitedWordsByFrequency))
                
                self.words = self.storageService.retrieveBook(withTitle: self.book?.title ?? "")?.word?
                    .compactMap { $0 }
                    .sorted { $0.name! < $1.name! }
            }
        }
    }
    
    //MARK: - Private Methods -
    
    private func prepareWords(for bookName: String) -> [String: Int] {
        guard let text = lem.readBook(bookName) else {
            return [:]
        }
        
        guard let lemmatized = lem.lemmatizeWords(text, in: 0..<text.words.count) else {
            return [:]
        }
        
        for stem in lemmatized {
           if let count = stats[stem] {
                stats[stem] = count + 1
            } else {
                stats[stem] = 1
            }
        }
        return stats
    }
    
    //MARK: - Actions -
    
    @objc private func handleAction() {
        router.pushBookDetailViewController(self.stats)
    }
}

// MARK: - Table view data source -

extension WordListViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return words?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Texts.CellsID.first, for: indexPath)
        let word = words?[indexPath.row]
        cell.textLabel?.text = word?.name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

// MARK: - Table view delegate -

extension WordListViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let word = words?[indexPath.row]
        router.pushWordDetailViewController(word: word)
    }
}

