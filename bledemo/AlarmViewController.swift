//
//  AlarmViewController.swift
//  bledemo
//
//  Created by xiaokelin on 26/01/2017.
//  Copyright © 2017 lxk. All rights reserved.
//

import UIKit
import AudioToolbox
import AVFoundation

class AlarmViewController: UIViewController,AVAudioPlayerDelegate  {
    var type:String=""
    var audioPlayer: AVAudioPlayer?
    @IBOutlet weak var alarmName: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title="警报"
        alarmName.text=type
        playAlarmSound("bell")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        Global.isOnAlarm=false
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    func playAlarmSound(_ soundName: String) {
        AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
        let url = URL(
            fileURLWithPath: Bundle.main.path(forResource: soundName, ofType: "mp3")!)
        
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
        }
        //negative number means loop infinity
        audioPlayer!.numberOfLoops = -1
        audioPlayer!.play()
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
    
    func stopAlarm(){
        self.audioPlayer?.stop()
    }



}
