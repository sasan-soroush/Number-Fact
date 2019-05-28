//
//  URLCreator.swift
//  Number Fact
//
//  Created by New User on 5/28/19.
//  Copyright © 2019 sasan soroush. All rights reserved.
//

import Foundation

class URLCreator {
    static let baseUrl = "http://numbersapi.com/"
    
    static func math(number : UInt ) -> String {
        let url = "\(baseUrl)\(number)/math?json"
        return url
    }
    
    static func trivia(number : UInt ) -> String {
        let url = "\(baseUrl)\(number)/trivia?json"
        return url
    }
    
    static func year(number : UInt ) -> String {
        let url = "\(baseUrl)\(number)/year?json"
        return url
    }
    
    static func date(day : UInt8 , month : UInt8) -> String {
        let url = "\(baseUrl)\(month)/\(day)/date?json"
        return url
    }
 }
