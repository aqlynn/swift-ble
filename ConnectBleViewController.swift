//
//  ConnectBleViewController.swift
//  bledemo
//
//  Created by xiaokelin on 25/01/2017.
//  Copyright © 2017 lxk. All rights reserved.
//

import UIKit

class ConnectBleViewController: UIViewController,BleSingletonDelegate {
    @IBOutlet weak var labelBle: UILabel!
    @IBOutlet weak var labelPower: UILabel!
    
    @IBOutlet weak var btnConnect: UIButton!
    var batteryView: BatteryView!
    @IBOutlet weak var btnDisconnect: UIButton!
    
    @IBOutlet weak var bg: UIImageView!
    
    
    @IBOutlet weak var labelRssi: UILabel!
    
    var bleSingleton: BleSingleton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title="连接设备"
        btnDisconnect.isHidden=true
        btnConnect.isHidden=true
        batteryView = BatteryView(frame: CGRect(x: 140, y: 30, width: 62, height: 120))
        batteryView.level = 0 // anywhere in 0...100
        batteryView.lowThreshold = 20
        batteryView.isHidden=true
        batteryView.center=self.view.center
        labelRssi.isHidden=true
        view.addSubview(batteryView)
        
        bleSingleton = BleSingleton.shareBleSingleton()
        self.bleSingleton.delegate = self
        self.bleSingleton.vc = self
        labelPower.isHidden=true

        if(Global.isConnected){
            bg.isHidden=true
            labelBle.text="设备已连接"
            batteryView.isHidden=false
            bleSingleton.readRSSI()
            bleSingleton.readPower()
            labelRssi.isHidden=false
        }

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if(Global.isConnected){
//            bg.isHidden=true
//            labelBle.text="设备已连接"
//            batteryView.isHidden=false
//            bleSingleton.readRSSI()
//            bleSingleton.readPower()
//            labelRssi.isHidden=false
        }else{
            bleSingleton.connectBle();
        }
        
        
    }
    
    func power(power: Int) {
        batteryView.level=power
        labelPower.isHidden=false
        labelPower.text="电量:\(power)%"
    }
    
    func rssi(rssi: NSNumber) {
        labelRssi.isHidden=false
        labelRssi.text="rssi:"+rssi.stringValue
        Global.rssi=rssi;
    }
    
    func connected() {
        bg.isHidden=true
        labelBle.text="设备已连接"
        batteryView.isHidden=false
    }
    
    func disconnected() {
        labelBle.text="设备已断开"
        bleSingleton.connectBle();
    }
    
    @IBAction func disconnect(_ sender: Any) {
        bleSingleton.disconnectBle();
    }
   
    @IBAction func connect(_ sender: Any) {
        bleSingleton.connectBle();
    }
    

}
