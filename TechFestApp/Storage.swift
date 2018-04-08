//
//  Storage.swift
//  TechFestApp
//
//  Created by Arnab Sen on 07/04/18.
//  Copyright © 2018 Arnab Sen. All rights reserved.
//

import Foundation
import FirebaseDatabase
import Firebase
import CoreGraphics


public class Storage{
    public static var ref: DatabaseReference!
    public static var refreshBufferValues : [[CGPoint]]!
    init() {
         FirebaseApp.configure()
         Storage.ref = Database.database().reference()
    }
    
    
    static func readRefreshBufferValues(of : String, completion : @escaping(_ val : [[Int]]) -> (Void)){
        var refreshBuffer : [[Int]]!
        print(Storage.ref.child(of).description())
        Storage.ref.child(of).observeSingleEvent(of: .value, with: { (snapshot) in
            refreshBuffer = snapshot.value as? [[Int]]
            completion(refreshBuffer)
            //print(refreshBuffer)
            } )
    }
    static func readBools(of: String, completion : @escaping ( _ val : Bool) -> (Void)){
        var boolVal : Bool!
        Storage.ref.child(of).observeSingleEvent(of: .value, with: { (snapshot) in
            if snapshot.value as? String == "false" {
                    boolVal = false
            }else{
                boolVal = true
            }
            completion(boolVal)
            })
    }
    static func readSliderValues(of : String, completion : @escaping (_ val : Float ) -> (Void)){
        var sliderVals : Float!
        Storage.ref.child(of).observeSingleEvent(of: .value, with: { (snapshot) in
            sliderVals = snapshot.value as? Float
            completion(sliderVals)
        })
    }
    static func setBoolValues(of : String ,with : Bool, completion : @escaping() ->()){
        Storage.ref.child(of).setValue(String(with))
    }
    static func setSliderValues(of: String, with: Float, completion : @escaping()->()){
        Storage.ref.child(of).setValue(Int(with))
    }
    static func setBufferValues(of : String, with: [CGPoint], completion: @escaping()->()){
        var tempInt : [[Int]]! = []
        for itr in 0...6{
            tempInt.append([Int(with[itr].x), Int(with[itr].y)])
        }
        Storage.ref.child(of).setValue(tempInt)
    }
}
