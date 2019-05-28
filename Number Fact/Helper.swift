//
//  Helper.swift
//  Number Fact
//
//  Created by New User on 5/28/19.
//  Copyright © 2019 sasan soroush. All rights reserved.
//

import Foundation
import UIKit

class Helper  {
    static func alert(_ controller:UIViewController, title:String, body:String){
        
        let alertController = UIAlertController(title: title, message:body, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default,handler: nil))
        controller.present(alertController, animated: true, completion: nil)
        
    }
    
    static func customIndicator(_ view : UIView , center : Bool = false) -> NVActivityIndicatorView {
        
        
        let size : CGFloat = 80
        let customIndicator : NVActivityIndicatorView = {
            let indicator = NVActivityIndicatorView(frame: CGRect(x: view.frame.midX - size/2, y: view.frame.midY - size/2, width: size, height: size))
            indicator.color = UIColor.white
            indicator.type = NVActivityIndicatorType(rawValue: 30)!
            return indicator
        }()
        
        return customIndicator
    }
}
