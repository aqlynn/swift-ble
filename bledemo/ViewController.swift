//
//  ViewController.swift
//  bledemo
//
//  Created by xiaokelin on 25/01/2017.
//  Copyright © 2017 lxk. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        


    }
    

    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            let vc:FunctionViewController = segue.destination as! FunctionViewController
            switch identifier {
            case "child":
                vc.type = 0;
            case "lost":
                 vc.type = 1;
            case "rob":
                  vc.type = 2;
            default: break
            }
        }
    }
    
    





}

