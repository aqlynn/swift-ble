//
//  GlobalParams.swift
//  Alarm-ios8-swift
//
//  Created by longyutao on 16/1/27.
//  Copyright (c) 2016年 LongGames. All rights reserved.
//

import Foundation

class Global
{
    static var power = 0
    static var isConnected: Bool = false
    static var rssi: NSNumber = 0
    static var alarmType: Int = -1
    static var isOnAlarm: Bool = false
    static var weekdays: [Int] = [Int]()
    static var mediaLabel: String = "bell"
    static var snoozeEnabled: Bool = false
    static var tuple: (type:Int,isOn:Bool) = (-1,false)
}
