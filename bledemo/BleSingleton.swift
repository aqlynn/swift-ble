//
//  BleSingleton.swift
//  bledemo
//
//  Created by xiaokelin on 26/01/2017.
//  Copyright © 2017 lxk. All rights reserved.
//

import Foundation
import UIKit


class BleSingleton: NSObject,CBCentralManagerDelegate,CBPeripheralDelegate {
    
    static let instance: BleSingleton = BleSingleton()
    
    // weak类型，防止循环引用
    weak var delegate: BleSingletonDelegate?
    var vc:UIViewController!
    var  myCentralManager:CBCentralManager!
    var  myPeripheral:CBPeripheral!
    var writeCharacteristic:CBCharacteristic!
    //设备名
    var DEVICENAME:String = "Finder"
    //特征名
    var CHARACTERISTIC:String = "2AF1"
    var SERVICEUUID:String = "6E400001-B5A3-F393-E0A9-E50E24DCCA9E"
    var WRITERCHARUUID:String = "6E400002-B5A3-F393-E0A9-E50E24DCCA9E"
    var READCHARUUID:String = "6E400003-B5A3-F393-E0A9-E50E24DCCA9E"
    
    //发送获取数据的指令
    var SECRETKEY:String = "938E0400080410"
    var getbytes :[UInt8]    = [0x55, 0x05, 0x05, 0x00, 0x00]
      /// 存储最终拼到一起的结果
    var result:String = ""
    
    
    class func shareBleSingleton() -> BleSingleton {
        return instance
    }
    
    private override init() {
        super.init()
        myCentralManager = CBCentralManager()
        myCentralManager.delegate = self
    }
    
    func readRSSI() {
        myPeripheral.readRSSI()
    }
    
    func readPower() {
        writeToPeripheral(getbytes)
    }
    
    func connectBle() {
        myCentralManager.scanForPeripherals(withServices: nil, options: nil)
    }
    
    func disconnectBle() {
        if(Global.isConnected){
            self.myCentralManager.cancelPeripheralConnection(myPeripheral);
        }

    }
    
    func peripheral(_ peripheral: CBPeripheral, didReadRSSI RSSI: NSNumber, error: Error?) {
        self.delegate?.rssi(rssi: RSSI)
        print("读到rssi \(RSSI)");
        
    }
    
    /**
     发送指令到设备
     */
    func writeToPeripheral(_ bytes:[UInt8]) {
        if writeCharacteristic != nil {
            let data1:Data = dataWithHexstring(bytes)
            self.myPeripheral.writeValue(data1, for: writeCharacteristic, type: CBCharacteristicWriteType.withResponse)
            
        } else{
            
            
        }
    }
    
    /**
     将[UInt8]数组转换为NSData
     
     - parameter bytes: <#bytes description#>
     
     - returns: <#return value description#>
     */
    
    func dataWithHexstring(_ bytes:[UInt8]) -> Data {
        let data = Data(bytes: UnsafePointer<UInt8>(bytes), count: bytes.count)
        return data
    }
    
    
    
    /**
     <#Description#>
     
     - parameter central:    <#central description#>
     - parameter peripheral: <#peripheral description#>
     - parameter error:      <#error description#>
     */
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        switch (central.state) {
        case .poweredOn:
            print("蓝牙已打开, 请扫描外设!");
            Global.isConnected=false;
            self.delegate?.disconnected()
            break;
        case .poweredOff:
            print("蓝牙关闭，请先打开蓝牙");
            Global.isConnected=false;
            self.delegate?.disconnected()
        default:
            break;
        }
    }
    
    func isBluetoothAvailable() -> Bool {
        if #available(iOS 10.0, *) {
            return myCentralManager.state == CBManagerState.poweredOn
        } else {
            return myCentralManager.state  == .poweredOn
        }
    }
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        print("-----centralManagerDidUpdateState----------")
        print(central.state)
    }
    
    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        print("--didFailToConnectPeripheral--")
    }
    //发现设备
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        print("--didDiscoverPeripheral-")
        if peripheral.name == DEVICENAME{
            self.myPeripheral = peripheral;
            self.myCentralManager = central;
            central.connect(self.myPeripheral, options: nil)
            print(self.myPeripheral);
            self.delegate?.rssi(rssi: RSSI)
        }
        
    }
    
    //设备已经接成功
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print("---------didConnectPeripheral-")
        print(central)
        print(peripheral)
        //关闭扫描
        self.myCentralManager.stopScan()
        self.myPeripheral.delegate = self
        self.myPeripheral.discoverServices(nil)
        print("扫描服务...");
         self.delegate?.connected()
        Global.isConnected=true;
    }
    
    
    func centralManager(_ central: CBCentralManager, willRestoreState dict: [String : Any]) {
        
        print("---------willRestoreState---------")
        
        
    }
    /**
     发现服务调用次方法
     
     - parameter peripheral: <#peripheral description#>
     - parameter error:      <#error description#>
     */
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        print("---发现服务调用次方法-")
        
        for s in peripheral.services!{
            peripheral.discoverCharacteristics(nil, for: s)
            print(s.uuid.uuidString)
        }
    }
    /**
     根据服务找特征
     
     - parameter peripheral: <#peripheral description#>
     - parameter service:    <#service description#>
     - parameter error:      <#error description#>
     */
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        print("----发现特征------")
        
        for c in service.characteristics! {
            
            if c.uuid.uuidString == READCHARUUID{
                print(c.uuid.uuidString)
                peripheral.setNotifyValue(true, for: c)
            }
            
            
            if c.uuid.uuidString == WRITERCHARUUID{
                print(c.uuid.uuidString)
                self.writeCharacteristic = c
            }
        }
         writeToPeripheral(getbytes)
        Timer.scheduledTimer(withTimeInterval: 7,
                             repeats: true,
                             block: { (timer) in
                                if(Global.isConnected){
                                     self.myPeripheral.readRSSI()
                                }
                               })
    }
    
    
    
    
    
    /**
     写入后的回掉方法
     
     - parameter peripheral:     <#peripheral description#>
     - parameter characteristic: <#characteristic description#>
     - parameter error:          <#error description#>
     */
    func peripheral(_ peripheral: CBPeripheral, didWriteValueFor characteristic: CBCharacteristic, error: Error?) {
        print("didWriteValueForCharacteristic")
    }
    
    /**
     <#Description#>
     
     - parameter peripheral:     <#peripheral description#>
     - parameter characteristic: <#characteristic description#>
     - parameter error:          <#error description#>
     */
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateNotificationStateFor characteristic: CBCharacteristic, error: Error?) {
        print("-----didUpdateNotificationStateForCharacteristic-----")
        if (error != nil) {
            print(error.customMirror);
        }
        //Notification has started
        if(characteristic.isNotifying){
            peripheral.readValue(for: characteristic);
            print(characteristic.uuid.uuidString);
        }
    }
    
    /**
     获取外设的数据
     
     - parameter peripheral:     <#peripheral description#>
     - parameter characteristic: <#characteristic description#>
     - parameter error:          <#error description#>
     */
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        print("----didUpdateValueForCharacteristic---")
        
        if  characteristic.uuid.uuidString == READCHARUUID  {
            let data:Data = characteristic.value!
            print(data)
            let  d  = Array(UnsafeBufferPointer(start: (data as NSData).bytes.bindMemory(to: UInt8.self, capacity: data.count), count: data.count))
            print(d)
            guard d.count>3 else {
                return
            }
            if(d[2]==04){
                 self.delegate?.power(power: Int(d[3]))
            }else if(d[2]==02){
                //acceleration
                print("----翻动异常---")
                guard(!Global.isOnAlarm)else{
                    return
                }
                Global.isOnAlarm=true
                
            
                let vc2 = (vc.storyboard?.instantiateViewController(withIdentifier: "alarm")) as! AlarmViewController
                vc2.type="防盗系统 当前rssi:\(Global.rssi)"
                //跳转
                vc.navigationController?.pushViewController( vc2, animated: true)


            }else if(d[1]==01){
                //button
                print("----蓝牙按键---")
            
                guard(!Global.isOnAlarm)else{
                    return
                }
                Global.isOnAlarm=true
                
                
                let vc2 = (vc.storyboard?.instantiateViewController(withIdentifier: "alarm")) as! AlarmViewController
                vc2.type="儿童安全 当前rssi:\(Global.rssi)"
                //跳转
                vc.navigationController?.pushViewController( vc2, animated: true)

            }
            
            
            let s:String =  HexUtil.encodeToString(d)
            print(s)
            
            
            
            
            //   if s != "00" {
            //       result += s
            //       print(result )
            //       print(result.characters.count )
            //   }
            
            //  if result.characters.count == 38 {
            //     lable.text = result
            //}
            
        }
    }
    

    
    
}








protocol BleSingletonDelegate: NSObjectProtocol {
    func power(power: Int) -> Void
    func connected() -> Void
    func disconnected() -> Void
    func rssi(rssi: NSNumber) -> Void
}

