//
//  SettingsViewController.swift
//  TechFestApp
//
//  Created by Arnab Sen on 06/04/18.
//  Copyright © 2018 Arnab Sen. All rights reserved.
//

import Foundation
import UIKit


class SettingsViewController : UIViewController{
    
    
    @IBOutlet weak var livingRoomSwitch: UISwitch!
    @IBOutlet weak var washroomSwitch: UISwitch!
    @IBOutlet weak var kitchenSwitch: UISwitch!
    @IBOutlet weak var lightSwitch: UISwitch!
    @IBOutlet weak var ACSwitch: UISwitch!
    @IBOutlet weak var fanSwitch: UISwitch!
    @IBOutlet weak var sensorSwitch: UISwitch!
    var livingRoom : Bool!
    @IBOutlet weak var securitySwitch: UISwitch!
    
    @IBAction func securitySwitchToggle(_ sender: UISwitch) {
        let alertWindow : UIAlertController = UIAlertController()
        if !securitySwitch.isOn{
            alertWindow.title =  "Security Controls"
            alertWindow.message = "Turning of this toggle will disable all security features.\nDo you wish to Continue?"
            alertWindow.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:{(action: UIAlertAction!) in
                self.securitySwitch.setOn(true, animated: true)
            }))
            alertWindow.addAction(UIAlertAction(title: "Turn Off", style: .destructive, handler: {
                (action : UIAlertAction) in
                self.securitySwitch.setOn(false, animated: true)
            }))
            self.present(alertWindow, animated: true, completion: nil)
        }
        
    }
    @IBAction func livingRoomSwitchToggle(_ sender: UISwitch) {
        let alertWindow : UIAlertController = UIAlertController()
        if !livingRoomSwitch.isOn{
            alertWindow.title =  "Living Room Controls"
            alertWindow.message = "Turning of this toggle will close all sensors. Do you wish to Continue?"
            alertWindow.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:{(action: UIAlertAction!) in
                self.livingRoomSwitch.setOn(true, animated: true)
            }))
            alertWindow.addAction(UIAlertAction(title: "Turn Off", style: .destructive, handler: {
                (action : UIAlertAction) in
                self.livingRoomSwitch.setOn(false, animated: true)
            }))
            self.present(alertWindow, animated: true, completion: nil)
        }
        
    }
    
    @IBAction func washRoomToggle(_ sender: UISwitch) {
        let alertWindow : UIAlertController = UIAlertController()
        if !washroomSwitch.isOn{
            alertWindow.title =  "Washroom Room Controls"
            alertWindow.message = "Turning of this toggle will close all sensors. Do you wish to Continue?"
            alertWindow.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:{(action: UIAlertAction!) in
                self.washroomSwitch.setOn(true, animated: true)
            }))
            alertWindow.addAction(UIAlertAction(title: "Turn Off", style: .destructive, handler: {
                (action : UIAlertAction) in
                self.washroomSwitch.setOn(false, animated: true)
            }))
            self.present(alertWindow, animated: true, completion: nil)
        }
        
    }
    
    @IBAction func kitchenToggle(_ sender: UISwitch) {
        let alertWindow : UIAlertController = UIAlertController()
        if !kitchenSwitch.isOn{
            alertWindow.title =  "Kitchen Controls"
            alertWindow.message = "Turning of this toggle will close all sensors. Do you wish to Continue?"
            alertWindow.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:{(action: UIAlertAction!) in
                self.kitchenSwitch.setOn(true, animated: true)
            }))
            alertWindow.addAction(UIAlertAction(title: "Turn Off", style: .destructive, handler: {
                (action : UIAlertAction) in
                self.kitchenSwitch.setOn(false, animated: true)
            }))
            self.present(alertWindow, animated: true, completion: nil)
        }
    }
    
    @IBAction func lightsToggle(_ sender: UISwitch) {
        let alertWindow : UIAlertController = UIAlertController()
        if !lightSwitch.isOn{
            alertWindow.title =  "All Lights Controls"
            alertWindow.message = "Turning of this toggle will disable all Lights. Do you wish to Continue?"
            alertWindow.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:{(action: UIAlertAction!) in
                self.lightSwitch.setOn(true, animated: true)
            }))
            alertWindow.addAction(UIAlertAction(title: "Turn Off", style: .destructive, handler: {
                (action : UIAlertAction) in
                self.lightSwitch.setOn(false, animated: true)
            }))
            self.present(alertWindow, animated: true, completion: nil)
        }
    }
    
    @IBAction func fansToggle(_ sender: UISwitch) {
        let alertWindow : UIAlertController = UIAlertController()
        if !fanSwitch.isOn{
            alertWindow.title =  "All Fans Controls"
            alertWindow.message = "Turning of this toggle will disable all Fans. Do you wish to Continue?"
            alertWindow.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:{(action: UIAlertAction!) in
                self.fanSwitch.setOn(true, animated: true)
            }))
            alertWindow.addAction(UIAlertAction(title: "Turn Off", style: .destructive, handler: {
                (action : UIAlertAction) in
                self.fanSwitch.setOn(false, animated: true)
            }))
            self.present(alertWindow, animated: true, completion: nil)
        }
    }
    @IBAction func ACtoggle(_ sender: UISwitch) {
        let alertWindow : UIAlertController = UIAlertController()
        if !ACSwitch.isOn{
            alertWindow.title =  "All AC Controls"
            alertWindow.message = "Turning of this toggle will disable all ACs. Do you wish to Continue?"
            alertWindow.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:{(action: UIAlertAction!) in
                self.ACSwitch.setOn(true, animated: true)
            }))
            alertWindow.addAction(UIAlertAction(title: "Turn Off", style: .destructive, handler: {
                (action : UIAlertAction) in
                self.ACSwitch.setOn(false, animated: true)
            }))
            self.present(alertWindow, animated: true, completion: nil)
        }
    }
    @IBAction func SensorsToggle(_ sender: UISwitch) {
        let alertWindow : UIAlertController = UIAlertController()
        if !sensorSwitch.isOn{
            alertWindow.title =  "All Sensors Controls"
            alertWindow.message = "Turning of this toggle will stop monitoring and disable all sensors.\nDo you wish to Continue?"
            alertWindow.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:{(action: UIAlertAction!) in
                self.sensorSwitch.setOn(true, animated: true)
            }))
            alertWindow.addAction(UIAlertAction(title: "Turn Off", style: .destructive, handler: {
                (action : UIAlertAction) in
                self.sensorSwitch.setOn(false, animated: true)
            }))
            self.present(alertWindow, animated: true, completion: nil)
        }
    }
    
    
    @IBAction func Done(_ sender: Any) {
        MainLogicClass.SettingsWriteBack["Rooms"]!["living"]! = livingRoomSwitch.isOn
        MainLogicClass.SettingsWriteBack["Rooms"]!["kitchen"]! = kitchenSwitch.isOn
        MainLogicClass.SettingsWriteBack["Rooms"]!["washroom"]! = washroomSwitch.isOn
        MainLogicClass.SettingsWriteBack["Rooms"]!["security"]! = securitySwitch.isOn
        MainLogicClass.SettingsWriteBack["Individual"]!["Lights"]! = lightSwitch.isOn
        MainLogicClass.SettingsWriteBack["Individual"]!["Fans"]! = fanSwitch.isOn
        MainLogicClass.SettingsWriteBack["Individual"]!["AC"]! = ACSwitch.isOn
        MainLogicClass.SettingsWriteBack["Individual"]!["Sensors"]! = sensorSwitch.isOn
        MainLogicClass.writeDataSettings()
         self.performSegue(withIdentifier: "MainPage", sender:self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        MainLogicClass.refreshSettings()
        livingRoomSwitch.setOn(MainLogicClass.Settings["Rooms"]!["living"]!, animated: true)
        securitySwitch.setOn(MainLogicClass.Settings["Rooms"]!["security"]!, animated: true)
        washroomSwitch.setOn(MainLogicClass.Settings["Rooms"]!["washroom"]!, animated: true)
        kitchenSwitch.setOn(MainLogicClass.Settings["Rooms"]!["kitchen"]!, animated: true)
        lightSwitch.setOn(MainLogicClass.Settings["Individual"]!["Lights"]!, animated: true)
        ACSwitch.setOn(MainLogicClass.Settings["Individual"]!["AC"]!, animated: true)
        fanSwitch.setOn(MainLogicClass.Settings["Individual"]!["Fans"]!, animated: true)
        sensorSwitch.setOn(MainLogicClass.Settings["Individual"]!["Sensors"]!, animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        MainLogicClass.refreshSettings()
        livingRoomSwitch.setOn(MainLogicClass.Settings["Rooms"]!["living"]!, animated: true)
        washroomSwitch.setOn(MainLogicClass.Settings["Rooms"]!["washroom"]!, animated: true)
        kitchenSwitch.setOn(MainLogicClass.Settings["Rooms"]!["kitchen"]!, animated: true)
         securitySwitch.setOn(MainLogicClass.Settings["Rooms"]!["security"]!, animated: true)
        lightSwitch.setOn(MainLogicClass.Settings["Individual"]!["Lights"]!, animated: true)
        ACSwitch.setOn(MainLogicClass.Settings["Individual"]!["AC"]!, animated: true)
        fanSwitch.setOn(MainLogicClass.Settings["Individual"]!["Fans"]!, animated: true)
        sensorSwitch.setOn(MainLogicClass.Settings["Individual"]!["Sensors"]!, animated: true)
    }
    
}
