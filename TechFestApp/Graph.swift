//
//  Graph.swift
//  TechFestApp
//
//  Created by Arnab Sen on 05/04/18.
//  Copyright © 2018 Arnab Sen. All rights reserved.
//
import UIKit
import CoreGraphics
import Foundation


class Graph: UIView{
    
    lazy var dummyRect : CGRect = CGRect(x: 0, y: 0, width: 100, height: 100)
    var refeshBuffer : [CGPoint] = [CGPoint(x: 0, y: 0), CGPoint(x: 10, y: 20), CGPoint(x: 40, y: 10), CGPoint(x:100,y:43)]
   
    override func draw(_ rect: CGRect)
    {
        
        let context = UIGraphicsGetCurrentContext()
        context?.setLineWidth(2.0)
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let components: [CGFloat] = [0.0, 0.0, 1.0, 1.0]
        let color = CGColor(colorSpace: colorSpace, components: components)
        context?.setStrokeColor(color!)
        context?.move(to: CGPoint(x: 0, y: 0))
        context?.addLines(between:  refeshBuffer)
        context?.strokePath()
    }
    
    func refresh(with: [CGPoint]){
        refeshBuffer  = with
        self.setNeedsDisplay()
    }
    
    
}
