//
//  AlarmViewController.swift
//  bledemo
//
//  Created by xiaokelin on 26/01/2017.
//  Copyright © 2017 lxk. All rights reserved.
//

import UIKit

class AlarmViewController: UIViewController {
    var type:String=""
    
    @IBOutlet weak var alarmName: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title="警报"
        alarmName.text=type
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

}
