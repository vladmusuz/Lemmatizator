//
//  SecondTableViewController.swift
//  Lemmatizator
//
//  Created by Kamol Ibragimov on 18/08/2020.
//  Copyright © 2020 g00dm0us3. All rights reserved.
//

import UIKit

final class SecondViewController: UIViewController {
    
    var word: Word? = nil {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: CellsID.second)
    }
}

// MARK: - Table view data source

extension SecondViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellsID.second, for: indexPath)
        cell.textLabel?.text = word?.name
        cell.detailTextLabel?.text = String(describing: word?.frequence)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
