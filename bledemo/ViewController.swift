//
//  ViewController.swift
//  bledemo
//
//  Created by xiaokelin on 25/01/2017.
//  Copyright © 2017 lxk. All rights reserved.
//

import UIKit

class ViewController: UIViewController,BleSingletonDelegate  {
    
    @IBOutlet weak var btn0: UIButton!
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btn3: UIButton!
    var bleSingleton: BleSingleton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title="首页"
        bleSingleton = BleSingleton.shareBleSingleton()
        self.bleSingleton.delegate = self


    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.bleSingleton.vc = self
        switch Global.tuple.type {
        case 0:
            initBtns()
            if(Global.tuple.isOn)
            {
                btn0.backgroundColor=UIColor(red: 80.0/255.0, green: 195.0/255.0, blue: 90.0/255.0, alpha: 1.0)
                btn0.setTitleColor(.white, for: .normal)
            }
        case 1:
             initBtns()
            if(Global.tuple.isOn)
            {
                btn1.backgroundColor=UIColor(red: 80.0/255.0, green: 195.0/255.0, blue: 90.0/255.0, alpha: 1.0)
                btn1.setTitleColor(.white, for: .normal)

            }
        case 2:
            initBtns()
            if(Global.tuple.isOn)
            {
                btn2.backgroundColor=UIColor(red: 80.0/255.0, green: 195.0/255.0, blue: 90.0/255.0, alpha: 1.0)
                btn2.setTitleColor(.white, for: .normal)

            }
        default:
            initBtns()
            break
        }
        
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
    
    func power(power: Int) {
        
    }
    
    func rssi(rssi: NSNumber) {
        Global.rssi=rssi;
       
    }
    
    func connected() {
       
    }
    
    func disconnected() {
        bleSingleton.connectBle();
    }
    
    
    func initBtns(){
    btn0.layer.cornerRadius = 20;
    btn0.backgroundColor=nil
    btn0.layer.masksToBounds = true;
    btn0.layer.borderWidth = 1.0;
    btn0.layer.borderColor = UIColor(red: 80.0/255.0, green: 195.0/255.0, blue: 90.0/255.0, alpha: 1.0).cgColor
    btn0.setTitleColor(UIColor(red: 80.0/255.0, green: 195.0/255.0, blue: 90.0/255.0, alpha: 1.0), for: .normal)

    btn1.backgroundColor=nil
    btn1.layer.cornerRadius = 20;
    btn1.layer.masksToBounds = true;
    btn1.layer.borderWidth = 1.0;
    btn1.layer.borderColor = UIColor(red: 80.0/255.0, green: 195.0/255.0, blue: 90.0/255.0, alpha: 1.0).cgColor
    btn1.setTitleColor(UIColor(red: 80.0/255.0, green: 195.0/255.0, blue: 90.0/255.0, alpha: 1.0), for: .normal)
    
    btn2.backgroundColor=nil
    btn2.layer.cornerRadius = 20;
    btn2.layer.masksToBounds = true;
    btn2.layer.borderWidth = 1.0;
    btn2.layer.borderColor = UIColor(red: 80.0/255.0, green: 195.0/255.0, blue: 90.0/255.0, alpha: 1.0).cgColor
    btn2.setTitleColor(UIColor(red: 80.0/255.0, green: 195.0/255.0, blue: 90.0/255.0, alpha: 1.0), for: .normal)
    
    btn3.backgroundColor=nil
    btn3.layer.cornerRadius = 20;
    btn3.layer.masksToBounds = true;
    btn3.layer.borderWidth = 1.0;
    btn3.layer.borderColor = UIColor(red: 80.0/255.0, green: 195.0/255.0, blue: 90.0/255.0, alpha: 1.0).cgColor
    btn3.setTitleColor(UIColor(red: 80.0/255.0, green: 195.0/255.0, blue: 90.0/255.0, alpha: 1.0), for: .normal)
    }

}

