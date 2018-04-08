//
//  AboutUIController.swift
//  TechFestApp
//
//  Created by Arnab Sen on 08/04/18.
//  Copyright © 2018 Arnab Sen. All rights reserved.
//

import Foundation
import UIKit
class AboutViewController : UIViewController{
    
    @IBAction func backToMain(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "AbouttoMain", sender:self)
    }
}
