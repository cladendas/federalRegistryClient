//
//  ViewController.swift
//  federalRegistryClient
//
//  Created by cladendas on 22.06.2021.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var enterObjectNum: UITextField!
    @IBOutlet weak var enterPasportNum: UITextField!
    @IBOutlet weak var enterRegion: UITextField!
    @IBOutlet weak var enterFirstName: UITextField!
    @IBOutlet weak var enterLastName: UITextField!
    @IBOutlet weak var enterTokenFSSP: UITextField!
    
    
    
    @IBAction func objectSearchButton(_ sender: UIButton) {
        
        if let tmpEnterNum = enterObjectNum.text, enterObjectNum.text != "" {
            let tmpVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(identifier: String(describing: ResultObjectSearchViewController.self)) as ResultObjectSearchViewController
            
            NetworkManager.num = tmpEnterNum
            tmpVC.tmpHeadLabel = tmpEnterNum
            
            NetworkManager.performSearchObject { (objects) in
                
                tmpVC.objects = objects
        
                DispatchQueue.main.async {
                    self.navigationController?.pushViewController(tmpVC, animated: true)
                }
            }
        }
    }
    
    @IBAction func mvdSearchButton(_ sender: UIButton)  {
        let tmpVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(identifier: String(describing: ResultMVDSearchViewController.self)) as ResultMVDSearchViewController
        
        self.navigationController?.pushViewController(tmpVC, animated: true)
    }
    
    @IBAction func fsspSearchButton(_ sender: UIButton)  {
        let tmpVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(identifier: String(describing: ResultFSSPSearchViewController.self)) as ResultFSSPSearchViewController
        
        self.navigationController?.pushViewController(tmpVC, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        enterObjectNum.text = "2:56:30302:639"
        // Do any additional setup after loading the view.
    }


}

