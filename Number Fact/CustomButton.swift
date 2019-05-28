//
//  CustomButton.swift
//  Number Fact
//
//  Created by New User on 10/6/18.
//  Copyright © 2018 sasan soroush. All rights reserved.
//

import UIKit

class CustomButton : UIButton {
    
    init(frame: CGRect , Type : Int) {
        super.init(frame: frame)
        
        titleLabel?.font = UIFont.systemFont(ofSize: 30, weight: UIFont.Weight.thin)
        setTitleColor(.white, for: UIControlState.normal)
        layer.cornerRadius = 8
        clipsToBounds = true
        tag = Type
        
        switch Type {
        case 1 :
            self.setGradientBackgroundColor(firstColor: UIColor.init(rgb: 0xA21EFC), secondColor: UIColor.init(rgb: 0x564EFE))
            self.setTitle("MATH", for: .normal)
        case 2 :
            self.setGradientBackgroundColor(firstColor: UIColor.init(rgb: 0xFD66B2), secondColor: UIColor.init(rgb: 0xFC8B64))
            self.setTitle("DATE", for: .normal)
        case 3 :
            self.setGradientBackgroundColor(firstColor: UIColor.init(rgb: 0x42D7C4), secondColor: UIColor.init(rgb: 0x119ED6))
            self.setTitle("YEAR", for: .normal)
        case 4 :
            self.setGradientBackgroundColor(firstColor: UIColor.init(rgb: 0xF0BC66), secondColor: UIColor.init(rgb: 0xEE6A35))
            self.setTitle("TRIVIA", for: .normal)
        default:
            break
        }
        
        if self.titleLabel != nil {
            bringSubview(toFront: self.titleLabel!)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
