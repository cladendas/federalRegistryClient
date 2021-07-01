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
        
        var sss = ""
        let tmpVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(identifier: String(describing: ResultFSSPSearchViewController.self)) as ResultFSSPSearchViewController
        
        if
            let region = enterRegion.text,
            let firstname = enterFirstName.text,
            let lastname = enterLastName.text,
            let token = enterTokenFSSP.text {
            

            NetworkManager.performSearchFSSP(region: region, firstname: firstname, lastname: lastname, token: token) { objectFSSP,task  in
                
//                tmpVC.objects = objectFSSP
                sss = task
                
                NetworkManager.performSearchFSSPTask(sss) { objects in
                    
                    print("sss", sss)
                    print("count 0", objects.count)
                    
                    tmpVC.objects = objects
                    
                    
                    DispatchQueue.main.async {
                        self.navigationController?.pushViewController(tmpVC, animated: true)
                        
                        print("count 1", objects.count)
                    }
                }
            }
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        enterObjectNum.text = "2:56:30302:639"
        
        enterRegion.text = "23"
        enterFirstName.text = "Артем"
        enterLastName.text = "Макаров"
        enterTokenFSSP.text = "DEfb4g87"
        
    }


}

