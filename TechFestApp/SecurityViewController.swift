//
//  SecurityViewController.swift
//  TechFestApp
//
//  Created by Arnab Sen on 09/04/18.
//  Copyright © 2018 Arnab Sen. All rights reserved.
//

import Foundation
import UIKit

class SecurityViewController : UIViewController{
    
    
    var didAnyoneChange : Bool = false
    
    @IBOutlet weak var activeLabel: UILabel!
    @IBOutlet weak var fireSwitch: UISwitch!
    @IBOutlet weak var bulgarAlarm: UISwitch!
    @IBOutlet weak var activityLabel: UILabel!
    
    
    @IBAction func fireAlarmToggle(_ sender: UISwitch) {
        fireSwitch.setOn(!fireSwitch.isOn, animated: true)
        self.didAnyoneChange = true
    }
    @IBAction func bulgarAlarmTogge(_ sender: Any) {
        bulgarAlarm.setOn(!bulgarAlarm.isOn, animated: true)
        self.didAnyoneChange = true
    }
    @IBAction func backToMain(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "SecurityToMain", sender:self)
        self.didAnyoneChange = true
    }
    @IBAction func doneButton(_ sender: UIBarButtonItem) {
        print("Done button")
        print(didAnyoneChange)
        if didAnyoneChange {
            if MainLogicClass.Settings["Rooms"]!["security"]! {
                Storage.setBoolValues(of: "SecurityFire", with: fireSwitch.isOn, completion: {})
                Storage.setBoolValues(of: "SecurityBulgar", with: fireSwitch.isOn, completion: {})
                self.performSegue(withIdentifier: "SecurityToMain", sender:self)
            }else{
                let alert : UIAlertController = UIAlertController(title: "Control is Disabled", message: "Security has been disabled in Global Settings\nSettings set here will not be permanent", preferredStyle: .actionSheet)
                    alert.addAction(UIAlertAction(title: "Go to Settings", style: .default, handler: {(UIAlertAction) in
                        MainLogicClass.refreshSettings()
                        self.performSegue(withIdentifier: "SecurityToSettings", sender:self)
                
                    }))
                alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: {(UIAlertAction) in
                    self.fireSwitch.setOn(MainLogicClass.Security["Fire"]! , animated: true)
                    self.bulgarAlarm.setOn(MainLogicClass.Security["Bulgar"]!, animated: true)
                        self.didAnyoneChange = false
              
                }))
                self.present(alert, animated: true, completion: {})
            }
       }else{
            self.performSegue(withIdentifier: "SecurityToMain", sender:self)
        }
    }
    
    override func viewDidLoad() {
        MainLogicClass.refreshSecurity()
        fireSwitch.setOn(MainLogicClass.Security["Fire"]!, animated: true)
        bulgarAlarm.setOn(MainLogicClass.Security["Bulgar"]!, animated: true)
        super.viewDidLoad()
        if MainLogicClass.Settings["Rooms"]!["security"]! {
            activeLabel.text = "Active"
            activeLabel.textColor = #colorLiteral(red: 0, green: 0.7603741818, blue: 0.4746940136, alpha: 1)
            Storage.readBools(of: "SecurityActivity", completion: {val in
                if val == true{
                    self.activityLabel.text = "Activity Detected. Take immediate action"
                    self.activityLabel.textColor = #colorLiteral(red: 0.8352941176, green: 0.2078431373, blue: 0, alpha: 1)
                }else{
                    self.activityLabel.text = "All Safe. No Action Required"
                    self.activityLabel.textColor = #colorLiteral(red: 0, green: 0.7603741818, blue: 0.4746940136, alpha: 1)
                }
            })
        }else{
            activeLabel.textColor = #colorLiteral(red: 0.8352941176, green: 0.2078431373, blue: 0.1019607857, alpha: 1)
            activeLabel.text = "Inactive"
            activityLabel.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
            activityLabel.text = "Security Controls turned off"
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        MainLogicClass.refreshSettings()
        MainLogicClass.refreshSecurity()
        fireSwitch.setOn(MainLogicClass.Security["Fire"]!, animated: true)
        bulgarAlarm.setOn(MainLogicClass.Security["Bulgar"]!, animated: true)
        if MainLogicClass.Settings["Rooms"]!["security"]! {
            Storage.readBools(of: "SecurityActivity", completion: {val in
                if val == true{
                    self.activityLabel.text = "Activity Detected. Take immediate action"
                    self.activityLabel.textColor = #colorLiteral(red: 0.8352941176, green: 0.2078431373, blue: 0, alpha: 1)
                }else{
                    self.activityLabel.text = "All Safe. No Action Required"
                    self.activityLabel.textColor = #colorLiteral(red: 0, green: 0.7603741818, blue: 0.4746940136, alpha: 1)
                }
            })
            activeLabel.text = "Active"
            activeLabel.textColor = #colorLiteral(red: 0, green: 0.7603741818, blue: 0.4746940136, alpha: 1)
            
        }else{
            activeLabel.textColor = #colorLiteral(red: 0.8352941176, green: 0.01176470588, blue: 0, alpha: 1)
            activeLabel.text = "Inactive"
            activityLabel.text = "Security Controls turned off"
            activityLabel.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        }
        
        
    }
    
}
