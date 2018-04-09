//
//  ViewController.swift
//  TechFestApp
//
//  Created by Arnab Sen on 04/04/18.
//  Copyright © 2018 Arnab Sen. All rights reserved.
//

import UIKit
import CoreGraphics
import FirebaseDatabase
import Firebase

class ViewController: UIViewController {
    
    static var isIntialised : Bool = false
    var mainVar : MainLogicClass?
    
    @IBAction func openSettings(_ sender: UIBarButtonItem) {
        MainLogicClass.refreshSettings()
        self.performSegue(withIdentifier: "SettingPage", sender:self)

    }
    @IBAction func openAbout(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "MainToAbout", sender:self)
    }
    @IBAction func openLivingRoom(_ sender: UIButton) {
         MainLogicClass.refreshSettings()
         MainLogicClass.refreshLivingRoom()
         self.performSegue(withIdentifier: "LivingRoomPage", sender:self)
    }
    
    @IBAction func openSecurity(_ sender: UIButton) {
        MainLogicClass.refreshSettings()
        MainLogicClass.refreshSecurity()
         self.performSegue(withIdentifier: "MainToSecurity", sender:self)
    }
    
    
    @IBAction func openWashroom(_ sender: UIButton) {
        MainLogicClass.refreshSettings()
        MainLogicClass.refreshKitchen()
        self.performSegue(withIdentifier: "WashroomPage", sender:self)
    }
    @IBAction func openKitchen(_ sender: UIButton) {
         MainLogicClass.refreshSettings()
         MainLogicClass.refreshKitchen()
         self.performSegue(withIdentifier: "KitchenPage", sender:self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if ViewController.isIntialised == false
        {
            ViewController.isIntialised = true
            mainVar = MainLogicClass()
            
        }
        MainLogicClass.refreshSettings()
        MainLogicClass.refreshSettings()
            
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        MainLogicClass.refreshSettings()
        MainLogicClass.refreshSecurity()
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    


}


