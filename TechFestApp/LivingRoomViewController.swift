//
//  LivingRoomViewController.swift
//  TechFestApp
//
//  Created by Arnab Sen on 07/04/18.
//  Copyright © 2018 Arnab Sen. All rights reserved.
//

import UIKit
import Foundation

class LivingRoomViewController : UIViewController{
    
    var didAnyoneChange : Bool = false
    
    @IBOutlet weak var activeLabel: UILabel!
    @IBOutlet weak var ACSwitch: UISwitch!
    @IBOutlet weak var livingRoomActivity: Graph!
    @IBOutlet weak var ACSlider: UISlider!
    @IBOutlet weak var ACVal: UILabel!
    @IBOutlet weak var lightsSwitch: UISwitch!
    @IBOutlet weak var fanSwitch: UISwitch!
    
    @IBAction func backToMain(_ sender: UIBarButtonItem) {
         self.performSegue(withIdentifier: "LivingRoomPageMain", sender:self)
    }
    
    @IBAction func openMainPage(_ sender: UIBarButtonItem) {
        if didAnyoneChange{
            if MainLogicClass.Settings["Rooms"]!["living"]! {
                Storage.setBoolValues(of: "LivingRoomACBool", with: ACSwitch.isOn, completion: {})
                Storage.setBoolValues(of: "LivingRoomFan", with: fanSwitch.isOn, completion: {})
                Storage.setBoolValues(of: "LivingRoomLight", with: lightsSwitch.isOn, completion: {})
                Storage.setSliderValues(of: "LivingRoomAC", with: ACSlider.value, completion: {})
                self.performSegue(withIdentifier: "LivingRoomPageMain", sender:self)
            }else{
                MainLogicClass.refreshSettings()
                let alert : UIAlertController = UIAlertController(title: "Control is Disabled", message: "Room has been disabled in Global Settings\nSettings set here will not be permanent", preferredStyle: .actionSheet)
                alert.addAction(UIAlertAction(title: "Go to Settings", style: .default, handler: {(UIAlertAction) in
                    MainLogicClass.refreshSettings()
                    self.performSegue(withIdentifier: "LivingtoSettings", sender:self)
                
                }))
                alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: {(UIAlertAction) in
                    self.ACSwitch.setOn(MainLogicClass.LivingRoom["ACState"] as! Bool , animated: true)
                    self.lightsSwitch.setOn(MainLogicClass.LivingRoom["Lights"] as! Bool, animated: true)
                    self.fanSwitch.setOn(MainLogicClass.LivingRoom["Fans"] as! Bool, animated: true)
                    self.ACSlider.setValue(MainLogicClass.LivingRoom["ACVal"] as! Float, animated: true)
                    self.ACVal.text = String(Int(self.ACSlider.value))
                    self.didAnyoneChange = false
                }))
                    self.present(alert, animated: true, completion: {})
            }
            }else{
                self.performSegue(withIdentifier: "LivingRoomPageMain", sender:self)
            }
    }
   
    @IBAction func ACSwitchToggle(_ sender: UISwitch) {
         ACSwitch.setOn(!ACSwitch.isOn, animated: true)
         didAnyoneChange = true
    }
    @IBAction func ACSliderAction(_ sender: UISlider) {
         ACVal.text = String(Int(ACSlider.value))
         didAnyoneChange = true
    }
    @IBAction func lightSwitchToggle(_ sender: UISwitch) {
        lightsSwitch.setOn(!lightsSwitch.isOn, animated: true)
        didAnyoneChange = true
    }
    
    @IBAction func fanSwitchToogle(_ sender: Any) {
        fanSwitch.setOn(!fanSwitch.isOn, animated: true)
        didAnyoneChange = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.livingRoomActivity.refresh(with: MainLogicClass.refreshBufferLiving)
        ACSlider.maximumValue = 100
        ACSlider.minimumValue = 0
        MainLogicClass.refreshLivingRoom()
        if MainLogicClass.Settings["Rooms"]!["living"]! {
            activeLabel.text = "Active"
            activeLabel.textColor = #colorLiteral(red: 0, green: 0.7603741818, blue: 0.4746940136, alpha: 1)
        }else{
            activeLabel.textColor = #colorLiteral(red: 0.8352941176, green: 0.2078431373, blue: 0, alpha: 1)
            activeLabel.text = "Inactive"
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        MainLogicClass.refreshLivingRoom()
        self.livingRoomActivity.refresh(with: MainLogicClass.refreshBufferLiving)
        if MainLogicClass.Settings["Rooms"]!["living"]! {
            activeLabel.text = "Active"
            activeLabel.textColor = #colorLiteral(red: 0, green: 0.7603741818, blue: 0.4746940136, alpha: 1)
        }else{
            activeLabel.textColor = #colorLiteral(red: 0.8352941176, green: 0.2078431373, blue: 0, alpha: 1)
            activeLabel.text = "Inactive"
        }
        ACSwitch.setOn(MainLogicClass.LivingRoom["ACState"] as! Bool , animated: true)
        lightsSwitch.setOn(MainLogicClass.LivingRoom["Lights"] as! Bool, animated: true)
        fanSwitch.setOn(MainLogicClass.LivingRoom["Fans"] as! Bool, animated: true)
        ACSlider.setValue(MainLogicClass.LivingRoom["ACVal"] as! Float, animated: true)
        ACVal.text = String(Int(ACSlider.value))
        
    }
}
