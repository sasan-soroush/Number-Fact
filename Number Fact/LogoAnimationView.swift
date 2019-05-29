//
//  LogoAnimationView.swift
//  Number Fact
//
//  Created by New User on 5/29/19.
//  Copyright © 2019 sasan soroush. All rights reserved.
//

import UIKit

class LogoAnimationView: UIView {
    
    var logoGifImageView : UIImageView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        
        self.backgroundColor = UIColor.init(rgb: 0x594CFE)
        
        do {
            logoGifImageView = try UIImageView(gifImage: UIImage(gifName: "SplashLogo.gif"), loopCount: 2)
        } catch {
            print(error)
        }
        
        guard logoGifImageView != nil else {return}
        
        addSubview(logoGifImageView!)
        let window = UIScreen.main.bounds
        logoGifImageView!.frame = CGRect(x: window.midX - 90, y: window.midY-90, width: 180, height: 180)
    }
}
