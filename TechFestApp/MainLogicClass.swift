//
//  MainLogicClassClass.swift
//  TechFestApp
//
//  Created by Arnab Sen on 07/04/18.
//  Copyright © 2018 Arnab Sen. All rights reserved.
//

import Foundation
import FirebaseDatabase
import Firebase
import CoreGraphics

class MainLogicClass{
    
    //Storing Refresh Buffer Variables for Each View
    static var refreshBufferMain : [CGPoint] = []
    static var refreshBufferKitchen : [CGPoint] = []
    static var refreshBufferLiving : [CGPoint] = []
    static var refreshBufferWashroom : [CGPoint] = []
    
    //Saving State of Each Button
    static var Settings : [String : [ String : Bool]] = ["Rooms" : ["living" : false, "washroom" : false, "kitchen" : false, "security" : false], "Individual" : ["AC": false, "Lights": false, "Fans" : false, "Sensors":false]]
    static var dummyFloat : Float = 0
    static var LivingRoom : [String : Any]! = ["ACState" : false, "ACVal" : Float(0), "Lights" : false, "Fans":false]
    static var Kitchen : [String : Any]! = ["ChimneyState" : false, "ChimneyVal" : Float(0), "Lights" : false]
    static var Washroom : [String : Bool]! = ["Lights":false, "Shower" : false]
    static var Security : [String : Bool]! = ["Fire": false, "Bulgar" : false]
    static var SettingsWriteBack : [String : [ String : Bool]] = ["Rooms" : ["living" : false, "security" : false, "washroom" : false, "kitchen" : false], "Individual" : ["AC": false, "Lights": false, "Fans" : false, "Sensors":false]]
    static var powerArray : [String : Int]! = ["living": 0, "washroom": 0, "kitchen":0, "global":0]
    
    init(){
        Storage.readRefreshBufferValues(of: "LivingRoomLog", completion: { val in
            print(val)
            for itr in 0...6{
                MainLogicClass.refreshBufferLiving.append(CGPoint(x: val[itr][0], y: val[itr][1]))
            }
        })
        Storage.readRefreshBufferValues(of: "WashroomLog", completion: { val in
            print(val)
            for itr in 0...6{
                MainLogicClass.refreshBufferWashroom.append(CGPoint(x: val[itr][0], y: val[itr][1]))
            }
        })
        Storage.readRefreshBufferValues(of: "KitchenLog", completion: { val in
            print(val)
            for itr in 0...6{
                MainLogicClass.refreshBufferKitchen.append(CGPoint(x: val[itr][0], y: val[itr][1]))
            }
        })
        
        
    }
    
    static func refreshBuffersAll(){
        Storage.readRefreshBufferValues(of: "LivingRoomLog", completion: { val in
            print(val)
            for itr in 0...6{
                MainLogicClass.refreshBufferLiving.append(CGPoint(x: val[itr][0], y: val[itr][1]))
            }
        })
        
        Storage.readRefreshBufferValues(of: "WashroomLog", completion: { val in
            print(val)
            for itr in 0...6{
                MainLogicClass.refreshBufferWashroom.append(CGPoint(x: val[itr][0], y: val[itr][1]))
            }
        })
        Storage.readRefreshBufferValues(of: "KitchenLog", completion: { val in
            print(val)
            for itr in 0...6{
                MainLogicClass.refreshBufferKitchen.append(CGPoint(x: val[itr][0], y: val[itr][1]))
            }
        })
        
    }
    static func refreshSettings(){
        
        //Read Global Bools : Individual
        Storage.readBools(of: "LightsBool", completion: {val in
            print(val)
            MainLogicClass.Settings["Individual"]!["Lights"] = val
        })
        Storage.readBools(of: "FansBool", completion: {val in
            print(val)
            MainLogicClass.Settings["Individual"]!["Fans"] = val
        })
        Storage.readBools(of: "ACBool", completion: {val in
            print(val)
            MainLogicClass.Settings["Individual"]!["AC"] = val
        })
        Storage.readBools(of: "SensorsBool", completion: {val in
            print(val)
            MainLogicClass.Settings["Individual"]!["Sensors"] = val
        })
        
        //Read Local Bools : Rooms
        Storage.readBools(of: "LivingRoom", completion: {val in
            print(val)
            MainLogicClass.Settings["Rooms"]!["living"] = val
        })
        
        Storage.readBools(of: "Kitchen", completion: {val in
            print(val)
            MainLogicClass.Settings["Rooms"]!["kitchen"] = val
        })
        Storage.readBools(of: "Washroom", completion: {val in
            print(val)
            MainLogicClass.Settings["Rooms"]!["washroom"] = val
        })
        Storage.readBools(of: "Security", completion: {val in
            MainLogicClass.Settings["Rooms"]!["security"] = val
            
        })
    }
    
    
    static func refreshLivingRoom(){
        MainLogicClass.refreshSettings()
        Storage.readSliderValues(of: "LivingRoomAC", completion: { val in
             MainLogicClass.LivingRoom["ACVal"] = val
        })
        Storage.readBools(of: "LivingRoomACBool", completion: {
            val in
            MainLogicClass.LivingRoom["ACState"] = val && MainLogicClass.Settings["Individual"]!["AC"]!
        })
        Storage.readBools(of: "LivingRoomLights", completion: {
            val in
            MainLogicClass.LivingRoom["Lights"] = val && MainLogicClass.Settings["Individual"]!["Lights"]!
        })
        Storage.readBools(of: "LivingRoomFan", completion: {
            val in
            MainLogicClass.LivingRoom["Fans"] = val && MainLogicClass.Settings["Individual"]!["Fans"]!
        })
        Storage.readRefreshBufferValues(of: "LivingRoomLog", completion: { val in
            MainLogicClass.refreshBufferLiving = []
            print(val)
            for itr in 0...6{
                MainLogicClass.refreshBufferLiving.append(CGPoint(x: val[itr][0], y: val[itr][1]))
            }
        })
    }
    static func refreshSecurity(){
        MainLogicClass.refreshSettings()
        Storage.readBools(of: "SecurityFire", completion: {val in
            MainLogicClass.Security["Fire"]! = val
        })
        Storage.readBools(of: "SecurityBulgar", completion: { val in
            MainLogicClass.Security["Bulgar"]! = val
        })
    }
    
    
    static func refreshKitchen(){
        MainLogicClass.refreshSettings()
        Storage.readRefreshBufferValues(of: "KitchenLog", completion: { val in
            print(val)
            MainLogicClass.refreshBufferKitchen = []
            for itr in 0...6{
                MainLogicClass.refreshBufferKitchen.append(CGPoint(x: val[itr][0], y: val[itr][1]))
            }
        })
        Storage.readBools(of: "ChimneyBool", completion: {
            val in
            MainLogicClass.Kitchen["ChimneyState"]  = val
        })
        Storage.readSliderValues(of: "ChimneySpeed", completion: { val in
            print("Kitchen")
            print(val)
            MainLogicClass.Kitchen["ChimneyVal"] = val
        })
        Storage.readBools(of: "KitchenLightsBool", completion: {
            val in
            MainLogicClass.Kitchen["Lights"] = val && MainLogicClass.Settings["Individual"]!["Lights"]!
        })
        
    }
    
    static func refreshWashroom(){
        MainLogicClass.refreshSettings()
        Storage.readRefreshBufferValues(of: "WashroomLog", completion: { val in
            print(val)
            MainLogicClass.refreshBufferWashroom = []
            for itr in 0...6{
                MainLogicClass.refreshBufferWashroom.append(CGPoint(x: val[itr][0], y: val[itr][1]))
            }
        })
        Storage.readBools(of: "WashroomShower", completion: {
            val in
            MainLogicClass.Washroom["Shower"] = val
        })
        Storage.readBools(of: "WashroomLights", completion: {
            val in
            MainLogicClass.Washroom["Lights"] = val && MainLogicClass.Settings["Individual"]!["Lights"]!
        })
    }
    
    static func writeDataSettings(){
        
        Storage.setBoolValues(of: "LivingRoom", with:MainLogicClass.SettingsWriteBack["Rooms"]!["living"]!, completion: {})
        Storage.setBoolValues(of: "Kitchen", with:MainLogicClass.SettingsWriteBack["Rooms"]!["kitchen"]!, completion: {})
        Storage.setBoolValues(of: "Washroom", with:MainLogicClass.SettingsWriteBack["Rooms"]!["washroom"]!, completion: {})
        Storage.setBoolValues(of: "Security", with:MainLogicClass.SettingsWriteBack["Rooms"]!["security"]!, completion: {})
        Storage.setBoolValues(of: "LigthsBool", with:MainLogicClass.SettingsWriteBack["Individual"]!["Lights"]!, completion: {})
        Storage.setBoolValues(of: "FansBool", with:MainLogicClass.SettingsWriteBack["Individual"]!["Fans"]!, completion: {})
        Storage.setBoolValues(of: "ACBool", with:MainLogicClass.SettingsWriteBack["Individual"]!["AC"]!, completion: {})
        Storage.setBoolValues(of: "SensorsBool", with:MainLogicClass.SettingsWriteBack["Individual"]!["Sensors"]!, completion: {})
        
    }
    static func refreshPowerValues(){
        Storage.readSliderValues(of: "GlobalPower", completion: {val in
            MainLogicClass.powerArray["global"]! = Int(val)
        })
        Storage.readSliderValues(of: "KitchenPower", completion: {val in
            MainLogicClass.powerArray["kitchen"]! = Int(val)
        })
        Storage.readSliderValues(of: "LivingRoomPower", completion: {val in
            MainLogicClass.powerArray["living"]! = Int(val)
        })
        Storage.readSliderValues(of: "WashroomPower", completion: {val in
            MainLogicClass.powerArray["washroom"]! = Int(val)
        })
    }
    static func refreshAll(){
        MainLogicClass.refreshSettings()
        MainLogicClass.refreshBuffersAll()
        MainLogicClass.refreshPowerValues()
        
    }
    static func backgroundAppRefresh(){
        print("BackGround App refrshed")
    }
    
    
    
}
