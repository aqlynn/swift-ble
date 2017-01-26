//
//  FunctionViewController.swift
//  bledemo
//
//  Created by xiaokelin on 25/01/2017.
//  Copyright © 2017 lxk. All rights reserved.
//

import UIKit

class FunctionViewController: UIViewController,BleSingletonDelegate {
    var bleSingleton: BleSingleton!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var labelFunction: UILabel!
    @IBOutlet weak var bleStatus: UILabel!
    var type:Int!
        override func viewDidLoad() {
        super.viewDidLoad()
            bleSingleton = BleSingleton.shareBleSingleton()
            self.bleSingleton.delegate = self
            if(type==1){
                 labelFunction.text="防丢系统"
                 image.image=UIImage(named: "1")
                self.navigationItem.title="防丢系统"
        
            }else if(type==2){
                labelFunction.text="防盗系统"
                image.image=UIImage(named: "3")
                self.navigationItem.title="防盗系统"

            }else if(type==0){
                labelFunction.text="儿童安全"
                image.image=UIImage(named: "2")
                self.navigationItem.title="儿童安全"
            }
            
            if(Global.isConnected){
                  bleStatus.text = "设备已连接 rssi:\(Global.rssi)"
            }else{
                bleStatus.text = "设备未连接"
            }


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func power(power: Int) {
        
    }
    
    func rssi(rssi: NSNumber) {
    
        if(Global.isConnected){
            bleStatus.text = "设备已连接 rssi:\(rssi.stringValue)"
        }else{
            bleStatus.text = "设备未连接"
        }
    }
    
    func connected() {
        bleStatus.text = "设备已连接"
    }
    
    func disconnected() {
        bleStatus.text = "设备已断开"
         bleSingleton.connectBle();
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
