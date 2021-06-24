//
//  ResultSearchViewController.swift
//  federalRegistryClient
//
//  Created by cladendas on 22.06.2021.
//

import UIKit

class ResultObjectSearchViewController: UIViewController {
    
    @IBOutlet weak var headLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var tmpHeadLabel = ""
    var objects: [Object] = []
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        headLabel.text = "Объекты по номеру \(tmpHeadLabel)"
        
        tableView.delegate = self
        tableView.dataSource = self

        // Do any additional setup after loading the view.
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
