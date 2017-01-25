//
//  FunctionViewController.swift
//  bledemo
//
//  Created by xiaokelin on 25/01/2017.
//  Copyright © 2017 lxk. All rights reserved.
//

import UIKit

class FunctionViewController: UIViewController {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var labelFunction: UILabel!
    var type:Int!
        override func viewDidLoad() {
        super.viewDidLoad()
            if(type==1){
                 labelFunction.text="防丢系统"
                 image.image=UIImage(named: "1")
            }else if(type==2){
                labelFunction.text="防盗系统"
                image.image=UIImage(named: "3")
            }else if(type==0){
                labelFunction.text="儿童安全"
                image.image=UIImage(named: "2")
            }


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
