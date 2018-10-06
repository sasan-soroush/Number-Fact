//
//  Enums.swift
//  Number Fact
//
//  Created by New User on 10/6/18.
//  Copyright © 2018 sasan soroush. All rights reserved.
//

import UIKit

enum Colors {
    case background , themeLight , themeYellow
    
    var rawValue : UIColor {
        get {
            switch self {
            case .background : return UIColor.init(rgb: 0x1A203A)
            case .themeLight : return UIColor.init(rgb: 0x262D49)
            case .themeYellow : return UIColor.init(rgb: 0xF0BC66)
            default:
                break
            }
        }
    }
}
