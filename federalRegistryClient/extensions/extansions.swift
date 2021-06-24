//
//  extensions.swift
//  federalRegistryClient
//
//  Created by cladendas on 22.06.2021.
//

import UIKit

extension ResultObjectSearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        objects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TableViewCell.self), for: indexPath) as! TableViewCell
        
        cell.title.text = objects[indexPath.row].addressNotes
        
        return cell
    }
}
