//
//  ResultFSSPSearchViewController.swift
//  federalRegistryClient
//
//  Created by cladendas on 24.06.2021.
//

import UIKit

class ResultFSSPSearchViewController: UIViewController {
    
    @IBOutlet weak var headLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var objects: [ResultResult] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
