//
//  AppDelegate.swift
//  bledemo
//
//  Created by xiaokelin on 25/01/2017.
//  Copyright © 2017 lxk. All rights reserved.
//

import UIKit
import AudioToolbox
import AVFoundation
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,AVAudioPlayerDelegate {

    var window: UIWindow?
    var audioPlayer: AVAudioPlayer?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
//        UINavigationBar.appearance().barTintColor = UIColor(red: 234.0/255.0, green: 46.0/255.0, blue: 73.0/255.0, alpha: 1.0)
       // UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName : UIColor(red: 37.0/255.0, green: 129.0/255.0, blue: 163.0/255.0, alpha: 1.0)]
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    //todo,vibration infinity
    func vibrationCallback(_ id:SystemSoundID, _ callback:UnsafeMutableRawPointer) -> Void
    {
        print("callback", terminator: "")
    }
    
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully
        flag: Bool) {
    }
    
    func audioPlayerDecodeErrorDidOccur(_ player: AVAudioPlayer,
                                        error: Error?) {
    }
    
    func audioPlayerBeginInterruption(_ player: AVAudioPlayer) {
    }
    
    //AlarmApplicationDelegate protocol
    func playAlarmSound(name:String,type:String) {
        if(Global.alarmType==0){
            if(Global.vibrate0){
                AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            }
            
        }else if(Global.alarmType==1){
            if(Global.vibrate1){
                AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            }
        }else if(Global.alarmType==2){
            if(Global.vibrate2){
                AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            }
        }
        
        let url = URL(
            fileURLWithPath: Bundle.main.path(forResource: name, ofType: type)!)
        
        var error: NSError?
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
        } catch let error1 as NSError {
            error = error1
            audioPlayer = nil
        }
        
        if let err = error {
            print("audioPlayer error \(err.localizedDescription)")
        } else {
            audioPlayer!.delegate = self
            audioPlayer!.prepareToPlay()
            
            if(Global.alarmType==0){
               audioPlayer!.volume=Global.volume0
            }else if(Global.alarmType==1){
                 audioPlayer!.volume=Global.volume1
            }else if(Global.alarmType==2){
                 audioPlayer!.volume=Global.volume2
                
            }
        }
        //negative number means loop infinity
        audioPlayer!.numberOfLoops = -1
        audioPlayer!.play()
    }
    
    func application(_ application: UIApplication, didReceive notification: UILocalNotification) {
        
        //
        //if app is in foreground, show a alert
        var s:String!
        if(Global.alarmType==0){
            s="儿童警报"
             playAlarmSound(name: "cry",type: "mp3")
        }else if(Global.alarmType==1){
            s="防丢警报 rssi:\(Global.rssi)"
            playAlarmSound(name: "fangdiu",type: "wav")
        }else if(Global.alarmType==2){
            s="防盗警报"
            playAlarmSound(name: "fangdao",type: "mp3")

        }
       
         let storageController = UIAlertController(title: s, message: nil, preferredStyle: .alert)
        let stopOption = UIAlertAction(title: "OK", style: .default) {
            (action:UIAlertAction)->Void in
//            guard(!Global.isOnAlarm)else{
//                return
//            }
//            Global.isOnAlarm=true
//            let vc2 = (UIStoryboard(name: "Main",bundle: nil).instantiateViewController(withIdentifier: "alarm")) as! AlarmViewController
//            vc2.type="儿童安全 当前rssi:\(Global.rssi)"
//            self.window?.rootViewController!.present(vc2, animated: true, completion: nil)
            self.audioPlayer?.stop()
            Global.isOnAlarm=false
            
        }
        storageController.addAction(stopOption)
        self.window?.rootViewController!.present(storageController, animated: true, completion: nil)
       }
    }



