//
//  DrawingRoomViewController.swift
//  TechFestApp
//
//  Created by Arnab Sen on 07/04/18.
//  Copyright © 2018 Arnab Sen. All rights reserved.
//

import Foundation
import UIKit
class DrawingRoomViewController : UIViewController{
    
    @IBOutlet weak var drawingRoomActivity: Graph!
    @IBOutlet weak var ACSwitch: UISwitch!
    @IBOutlet weak var FanSwitch: UISwitch!
    @IBOutlet weak var LightSwitch: UISwitch!
    @IBOutlet weak var ACVal: UILabel!
    @IBOutlet weak var ACSlider: UISlider!
    
    @IBOutlet weak var activeLabel: UILabel!
    @IBAction func backToMain(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "DrawingRoomPageMain", sender:self)
    }
    @IBAction func openMainPage(_ sender: UIBarButtonItem) {
        if MainLogicClass.Settings["Rooms"]!["drawing"]! {
        Storage.setBoolValues(of: "DrawingRoomACBool", with: ACSwitch.isOn, completion: {})
        Storage.setBoolValues(of: "DrawingRoomFan", with: FanSwitch.isOn, completion: {})
        Storage.setBoolValues(of: "DrawingRoomLight", with: LightSwitch.isOn, completion: {})
        Storage.setSliderValues(of: "DrawingRoomAC", with: ACSlider.value, completion: {})
        self.performSegue(withIdentifier: "DrawingRoomPageMain", sender:self)
        }else{
            let alert : UIAlertController = UIAlertController(title: "Control is Disabled", message: "Room has been disabled in Global Settings\nSettings set here will not be permanet", preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "Go to Settings", style: .default, handler: {(UIAlertAction) in
                MainLogicClass.refreshSettings()
                self.performSegue(withIdentifier: "DrawingtoSettings", sender:self)
                
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: {(UIAlertAction) in
                self.ACSwitch.setOn(MainLogicClass.DrawingRoom["ACState"] as! Bool , animated: true)
                self.LightSwitch.setOn(MainLogicClass.DrawingRoom["Lights"] as! Bool, animated: true)
                self.FanSwitch.setOn(MainLogicClass.DrawingRoom["Fans"] as! Bool, animated: true)
                self.ACSlider.setValue(MainLogicClass.DrawingRoom["ACVal"] as! Float, animated: true)
                self.ACVal.text = String(Int(self.ACSlider.value))
            }))
            self.present(alert, animated: true, completion: {
                
            })
        }
    }
    @IBAction func ACSwitchToggle(_ sender: UISwitch) {
        ACSwitch.setOn(!ACSwitch.isOn, animated: true)
    }
    @IBAction func ACSliderToggle(_ sender: UISlider) {
        ACVal.text = String(Int(ACSlider.value))
    }
    
    @IBAction func fanToggle(_ sender: UISwitch) {
        FanSwitch.setOn(!FanSwitch.isOn, animated: true)
       
    }
    @IBAction func lightToggle(_ sender: UISwitch) {
        LightSwitch.setOn(!LightSwitch.isOn, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        MainLogicClass.refreshDrawingRoom()
        self.drawingRoomActivity.refresh(with: MainLogicClass.refreshBufferDrawing)
        ACSlider.maximumValue = 100
        ACSlider.minimumValue = 0
        MainLogicClass.refreshLivingRoom()
        if MainLogicClass.Settings["Rooms"]!["living"]! {
            activeLabel.text = "Active"
            activeLabel.textColor = #colorLiteral(red: 0, green: 0.9796395898, blue: 0.4746940136, alpha: 1)
        }else{
            activeLabel.textColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
            activeLabel.text = "Inactive"
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        MainLogicClass.refreshDrawingRoom()
        self.drawingRoomActivity.refresh(with: MainLogicClass.refreshBufferDrawing)
        if MainLogicClass.Settings["Rooms"]!["drawing"]! {
            activeLabel.text = "Active"
            activeLabel.textColor = #colorLiteral(red: 0, green: 0.9796395898, blue: 0.4746940136, alpha: 1)
        }else{
            activeLabel.textColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
            activeLabel.text = "Inactive"
        }
        ACSwitch.setOn(MainLogicClass.DrawingRoom["ACState"] as! Bool , animated: true)
        LightSwitch.setOn(MainLogicClass.DrawingRoom["Lights"] as! Bool, animated: true)
        FanSwitch.setOn(MainLogicClass.DrawingRoom["Fans"] as! Bool, animated: true)
        ACSlider.setValue(MainLogicClass.DrawingRoom["ACVal"] as! Float, animated: true)
        ACVal.text = String(Int(ACSlider.value))
        
    }
    
}
