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
   
    @IBOutlet weak var funSwitch: UISwitch!
   
    @IBOutlet weak var volume: UISlider!
    
    @IBOutlet weak var vibrate: UISwitch!

    @IBOutlet weak var strengthSegment: UISegmentedControl!
    var type:Int!
    
    @IBOutlet weak var strengthStack: UIStackView!
    
        override func viewDidLoad() {
        super.viewDidLoad()
             strengthSegment.selectedSegmentIndex=Global.strength
            self.navigationItem.rightBarButtonItem=UIBarButtonItem(image:UIImage(named:"5"), style:.plain , target: self, action: #selector(FunctionViewController.sayHello(sender:)))
            bleSingleton = BleSingleton.shareBleSingleton()
            self.bleSingleton.delegate = self
             Global.tuple=(type,true)
        
            
            funSwitch.isOn = true;
    
            funSwitch.addTarget(self, action:#selector(FunctionViewController.switchDidChange(sender:)), for:.valueChanged)
            vibrate.addTarget(self, action: #selector(switchDidChange2), for:.valueChanged)
            
            if(type==1){
                vibrate.isOn=Global.vibrate1
                volume.value=Global.volume1
                 labelFunction.text="防丢系统"
                 image.image=UIImage(named: "1")
                self.navigationItem.title="防丢系统"
        
            }else if(type==2){
                 vibrate.isOn=Global.vibrate2
                volume.value=Global.volume2
                labelFunction.text="防盗系统"
                strengthStack.isHidden=true
                image.image=UIImage(named: "3")
                self.navigationItem.title="防盗系统"
               

            }else if(type==0){
                vibrate.isOn=Global.vibrate0
                 volume.value=Global.volume0
                labelFunction.text="儿童安全"
                 strengthStack.isHidden=true
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
    

    func sayHello(sender: UIBarButtonItem) {
         self.performSegue(withIdentifier: "setting", sender: self)
    }
    
    @IBAction func segmentClick(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex
        {
        case 0:
            Global.strength=0
            break
            
        case 1:
             Global.strength=1
            break
        case 2:
            Global.strength=2
            break
        default:
             Global.strength=1
            break; 
        }
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if(segue.identifier=="setting"){
//            var vc=segue.destination as! SettingTableViewController
//        }
    }
    
    func switchDidChange(sender:UISwitch){
        //打印当前值
        print(sender.isOn)
        Global.tuple=(type,funSwitch.isOn)
    }
    

    
    //vibrate
    func switchDidChange2(){
        if(type==1){
            Global.vibrate1=vibrate.isOn
        }else if(type==2){
            Global.vibrate2=vibrate.isOn
            
        }else if(type==0){
           Global.vibrate0=vibrate.isOn
        }
    }
    
   
    
    @IBAction func volumeChanged(_ sender: Any) {
        let slider:UISlider=sender as! UISlider
        print(slider.value)
        if(type==1){
             Global.volume1=slider.value
            
        }else if(type==2){
            Global.volume2=slider.value

        }else if(type==0){
            Global.volume0=slider.value

        }

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.bleSingleton.vc = self
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func power(power: Int) {
        
    }
    
    func rssi(rssi: NSNumber) {
        Global.rssi=rssi;
        if(Global.isConnected){
            bleStatus.text = "设备已连接 rssi:\(rssi.stringValue)"
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
