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
        
        
        
        let customIndicator : NVActivityIndicatorView = {
            let indicator = NVActivityIndicatorView(frame: CGRect(x: view.frame.width/2 - 30, y: view.frame.height/4 * (center ? 2 : 3) - 30, width: 60, height: 60))
            indicator.color = UIColor.init(rgb: 0xEE6A35)
            indicator.type = NVActivityIndicatorType(rawValue: 22)!
            return indicator
        }()
        
        return customIndicator
    }
}
