//
//  Extentions.swift
//  Number Fact
//
//  Created by New User on 10/6/18.
//  Copyright © 2018 sasan soroush. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}

extension UIView {
    func setGradientBackgroundColor(firstColor : UIColor , secondColor : UIColor) {
        
        let gradiendLayer = CAGradientLayer()
        gradiendLayer.frame = bounds
        gradiendLayer.colors = [firstColor.cgColor , secondColor.cgColor]
        gradiendLayer.startPoint = CGPoint(x: 1.0, y: 0.1)
        gradiendLayer.endPoint = CGPoint(x: 0.0, y: 0.0)
        layer.insertSublayer(gradiendLayer, at: 1)
        
    }
    
    
    
}





















