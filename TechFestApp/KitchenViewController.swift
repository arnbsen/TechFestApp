//
//  KitchenViewController.swift
//  TechFestApp
//
//  Created by Arnab Sen on 07/04/18.
//  Copyright © 2018 Arnab Sen. All rights reserved.
//

import Foundation
import UIKit
import CoreGraphics

class KitchenViewController : UIViewController{
    static let initArray : [CGPoint] = [CGPoint(x: 0, y:44.5) , CGPoint(x:280, y:135)]
    var didAnyoneChange : Bool = false
    
    @IBOutlet weak var ActivityKitchen: Graph!
    @IBOutlet weak var chimmeytoggle: UISwitch!
    @IBOutlet weak var lightToggle: UISwitch!
    @IBOutlet weak var chimmeySlider: UISlider!
    @IBOutlet weak var chimneyLabel: UILabel!
    @IBOutlet weak var activeLabel: UILabel!
    
    @IBAction func backToMain(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "KitchenPageMain", sender:self)
    }
    
    @IBAction func openMain(_ sender: UIBarButtonItem) {
        if didAnyoneChange{
            if MainLogicClass.Settings["Rooms"]!["kitchen"]!{
                Storage.setSliderValues(of: "ChimneySpeed", with: chimmeySlider.value, completion: {})
                Storage.setBoolValues(of: "ChimneyBool", with: chimmeytoggle.isOn, completion: {})
                Storage.setBoolValues(of: "KitchenLightsBool", with: lightToggle.isOn, completion: {})
                self.performSegue(withIdentifier: "KitchenPageMain", sender:self)
            }else{
                let alert : UIAlertController = UIAlertController(title: "Control is Disabled", message: "Room has been disabled in Global Settings\nSettings set here will not be permanent", preferredStyle: .actionSheet)
                alert.addAction(UIAlertAction(title: "Go to Settings", style: .default, handler: {(UIAlertAction) in
                    MainLogicClass.refreshSettings()
                    self.performSegue(withIdentifier: "KitchentoSettings", sender:self)
                
                }))
                alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: {(UIAlertAction) in
                    self.chimmeytoggle.setOn(MainLogicClass.Kitchen["ChimneyState"] as! Bool , animated: true)
                    self.lightToggle.setOn(MainLogicClass.Kitchen["Lights"] as! Bool, animated: true)
                    self.chimmeySlider.setValue(MainLogicClass.Kitchen["ChimneyVal"] as! Float, animated: true)
                    self.chimneyLabel.text = String(Int(self.chimmeySlider.value))
                    self.didAnyoneChange = false
                }))
                self.present(alert, animated: true, completion: {})
        }
        }else{
             self.performSegue(withIdentifier: "KitchenPageMain", sender:self)
        }
    }
    
    @IBAction func chimeyToggleAction(_ sender: UISwitch) {
        chimmeytoggle.setOn(!chimmeytoggle.isOn, animated: true)
        didAnyoneChange = true
    }
    
    @IBAction func chimneySlider(_ sender: UISlider) {
         chimneyLabel.text = String(Int(chimmeySlider.value))
        didAnyoneChange = true
    }
    @IBAction func lightToggle(_ sender: UISwitch) {
        lightToggle.setOn(!lightToggle.isOn, animated: true)
        didAnyoneChange = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.ActivityKitchen.refresh(with: MainLogicClass.refreshBufferKitchen)
        chimmeySlider.maximumValue = 100
        chimmeySlider.minimumValue = 0
        MainLogicClass.refreshLivingRoom()
        if MainLogicClass.Settings["Rooms"]!["kitchen"]! {
            activeLabel.text = "Active"
            activeLabel.textColor = #colorLiteral(red: 0, green: 0.7603741818, blue: 0.4746940136, alpha: 1)
        }else{
            activeLabel.textColor = #colorLiteral(red: 0.8352941176, green: 0.2078431373, blue: 0, alpha: 1)
            activeLabel.text = "Inactive"
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        MainLogicClass.refreshKitchen()
        self.ActivityKitchen.refresh(with: MainLogicClass.refreshBufferKitchen)
        if MainLogicClass.Settings["Rooms"]!["kitchen"]! {
            activeLabel.text = "Active"
            activeLabel.textColor = #colorLiteral(red: 0, green: 0.7603741818, blue: 0.4746940136, alpha: 1)
        }else{
            activeLabel.textColor = #colorLiteral(red: 0.8352941176, green: 0.2078431373, blue: 0, alpha: 1)
            activeLabel.text = "Inactive"
        }
        chimmeytoggle.setOn(MainLogicClass.Kitchen["ChimneyState"] as! Bool , animated: true)
        lightToggle.setOn(MainLogicClass.Kitchen["Lights"] as! Bool, animated: true)
        chimmeySlider.setValue(MainLogicClass.Kitchen["ChimneyVal"] as! Float, animated: true)
        chimneyLabel.text = String(Int(chimmeySlider.value))
        
    }
}
