//
//  ViewController.swift
//  bledemo
//
//  Created by xiaokelin on 25/01/2017.
//  Copyright © 2017 lxk. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var btn0: UIButton!
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btn3: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title="首页"
        btn0.layer.cornerRadius = 20;
        btn0.layer.masksToBounds = true;
        btn0.layer.borderWidth = 1.0;
        btn0.layer.borderColor = UIColor.green.cgColor
        
        btn1.layer.cornerRadius = 20;
        btn1.layer.masksToBounds = true;
        btn1.layer.borderWidth = 1.0;
        btn1.layer.borderColor = UIColor.green.cgColor

        
        btn2.layer.cornerRadius = 20;
        btn2.layer.masksToBounds = true;
        btn2.layer.borderWidth = 1.0;
        btn2.layer.borderColor = UIColor.green.cgColor

        
        btn3.layer.cornerRadius = 20;
        btn3.layer.masksToBounds = true;
        btn3.layer.borderWidth = 1.0;
        btn3.layer.borderColor = UIColor.green.cgColor


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

