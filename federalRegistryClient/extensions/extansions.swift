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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: RegistryTableViewCell.self), for: indexPath) as! RegistryTableViewCell
        
        cell.title.text = objects[indexPath.row].addressNotes
        
        return cell
    }
}


extension ResultFSSPSearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        objects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: FSSPTableViewCell.self), for: indexPath) as! FSSPTableViewCell
        
//        cell.name.text = objects[indexPath.row].name
//        cell.exeProduction.text = objects[indexPath.row].exeProduction
//        cell.details.text = objects[indexPath.row].details
//        cell.subject.text = objects[indexPath.row].subject
//        cell.department.text = objects[indexPath.row].department
//        cell.bailiff.text = objects[indexPath.row].bailiff
        
        return cell
    }
}
