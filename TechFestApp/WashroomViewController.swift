//
//  WashroomViewController.swift
//  TechFestApp
//
//  Created by Arnab Sen on 07/04/18.
//  Copyright © 2018 Arnab Sen. All rights reserved.
//

import Foundation
import UIKit
class WashroomViewController : UIViewController{
    
    var didAnyoneChange : Bool = false
    
    @IBOutlet weak var washroomActivity: Graph!
    @IBOutlet weak var showerSwitch: UISwitch!
    @IBOutlet weak var lightsSwitch: UISwitch!
    @IBOutlet weak var activeLabel: UILabel!
    
    
    @IBAction func backToMain(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "WashroomPageMain", sender:self)
    }
    @IBAction func openMain(_ sender: UIBarButtonItem) {
         if didAnyoneChange {
            if MainLogicClass.Settings["Rooms"]!["washroom"]!{
                Storage.setBoolValues(of: "WashroomShower", with: showerSwitch.isOn, completion: {})
                Storage.setBoolValues(of: "WashroomLights", with: lightsSwitch.isOn, completion: {})
                self.performSegue(withIdentifier: "WashroomPageMain", sender:self)
            }else{
                MainLogicClass.refreshSettings()
                let alert : UIAlertController = UIAlertController(title: "Control is Disabled", message: "Room has been disabled in Global Settings\nSettings set here will not be permanet", preferredStyle: .actionSheet)
                    alert.addAction(UIAlertAction(title: "Go to Settings", style: .default, handler: {(UIAlertAction) in
                        MainLogicClass.refreshSettings()
                        self.performSegue(withIdentifier: "WashroomtoSettings", sender:self)
                
                    }))
                alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: {(UIAlertAction) in
                    self.lightsSwitch.setOn(MainLogicClass.Washroom["Lights"]!, animated: true)
                    self.showerSwitch.setOn(MainLogicClass.Washroom["Shower"]!, animated: true)
                    self.didAnyoneChange = false
                }))
                self.present(alert, animated: true, completion: {
                })
            }
         }else{
            self.performSegue(withIdentifier: "WashroomPageMain", sender:self)

        }
    }
    @IBAction func showerControl(_ sender: UISwitch) {
        showerSwitch.setOn(!showerSwitch.isOn, animated: true)
        didAnyoneChange = true
    }
    
    @IBAction func lightControl(_ sender: UISwitch) {
        lightsSwitch.setOn(!lightsSwitch.isOn, animated: true)
        didAnyoneChange = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        washroomActivity.refresh(with: MainLogicClass.refreshBufferWashroom)
        MainLogicClass.refreshWashroom()
        self.washroomActivity.refresh(with: MainLogicClass.refreshBufferWashroom)
        if MainLogicClass.Settings["Rooms"]!["washroom"]! {
            activeLabel.text = "Active"
            activeLabel.textColor = #colorLiteral(red: 0, green: 0.7603741818, blue: 0.4746940136, alpha: 1)
        }else{
            activeLabel.textColor = #colorLiteral(red: 0.8352941176, green: 0.2078431373, blue: 0, alpha: 1)
            activeLabel.text = "Inactive"
        }
        lightsSwitch.setOn(MainLogicClass.Washroom["Lights"]!, animated: true)
        showerSwitch.setOn(MainLogicClass.Washroom["Shower"]!, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        MainLogicClass.refreshWashroom()
        self.washroomActivity.refresh(with: MainLogicClass.refreshBufferWashroom)
        if MainLogicClass.Settings["Rooms"]!["washroom"]! {
            activeLabel.text = "Active"
            activeLabel.textColor = #colorLiteral(red: 0, green: 0.7603741818, blue: 0.4746940136, alpha: 1)
        }else{
            activeLabel.textColor = #colorLiteral(red: 0.8352941176, green: 0.2078431373, blue: 0, alpha: 1)
            activeLabel.text = "Inactive"
        }
        lightsSwitch.setOn(MainLogicClass.Washroom["Lights"]!, animated: true)
        showerSwitch.setOn(MainLogicClass.Washroom["Shower"]!, animated: true)
        
    }
}
