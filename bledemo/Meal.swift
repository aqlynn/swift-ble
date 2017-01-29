//
//  Meal.swift
//  FoodTracker
//
//  Created by Jane Appleseed on 11/10/16.
//  Copyright © 2016 Apple Inc. All rights reserved.
//

import UIKit
import os.log


class Meal: NSObject, NSCoding {
    
    //MARK: Properties
    
    var volume: Float=1
    var photo: UIImage?
    var isVibrate: Bool=true
    
    //MARK: Archiving Paths
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("ble")
    
    //MARK: Types
    
    struct PropertyKey {
        static let volume = "volume"
        static let photo = "photo"
        static let isVibrate = "isVibrate"
    }
    
    //MARK: Initialization
    
    init?(volume: Float, photo: UIImage?, isVibrate: Bool) {
        
       
       // self.volume = volume
        self.photo = photo
        self.isVibrate = isVibrate
        
    }
    
    //MARK: NSCoding
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(volume, forKey: PropertyKey.volume)
        aCoder.encode(photo, forKey: PropertyKey.photo)
        aCoder.encode(isVibrate, forKey: PropertyKey.isVibrate)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        // The name is required. If we cannot decode a name string, the initializer should fail.
    
        
        // Because photo is an optional property of Meal, just use conditional cast.
        let photo = aDecoder.decodeObject(forKey: PropertyKey.photo) as? UIImage
        
        //let isVibrate = aDecoder.decodeInteger(forKey: PropertyKey.isVibrate)
        
         //let volume = aDecoder.decodeInteger(forKey: PropertyKey.volume)
        
        // Must call designated initializer.
        self.init(volume: 1, photo: photo, isVibrate: true)
        
    }
}
