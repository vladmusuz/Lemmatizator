//
//  SecondTableViewController.swift
//  Lemmatizator
//
//  Created by Kamol Ibragimov on 18/08/2020.
//  Copyright © 2020 g00dm0us3. All rights reserved.
//

import UIKit

final class WordDetailViewController: UITableViewController {
    
    var definitionService = DefinitionService()
    
    var defenitions: [String]? = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    var word: Word? = nil {
        didSet {
            fetchDefeniotions()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    private func fetchDefeniotions() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Texts.CellsID.second)
        
        definitionService.fetchDefenition(word: word?.name ?? "", success: { object in
            self.defenitions = object?.def.first?.tr.first?.syn?.compactMap({ defenition -> String? in
                return defenition.text
            })
        }) { error in
            print(error.localizedDescription)
        }
    }
}

// MARK: - Table view data source

extension WordDetailViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = defenitions?.count, count > 0 {
            return count
        } else {
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if var cell = tableView.dequeueReusableCell(withIdentifier: Texts.CellsID.second) {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: Texts.CellsID.second)
            if let defenitions = defenitions {
                cell.textLabel?.text = defenitions[indexPath.row]
            } else {
                cell.textLabel?.text = "\(Texts.couldNotFindDefenition) \(word?.name ?? "")"
            }
            return cell
        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
