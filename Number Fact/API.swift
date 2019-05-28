//
//  API.swift
//  Number Fact
//
//  Created by New User on 5/28/19.
//  Copyright © 2019 sasan soroush. All rights reserved.
//

import Foundation

class API {
    
    // success , number response
    typealias NumberInfoCompletionHandler  = (Bool , NumberInfo?) -> ()
    
    static func getInformation(number : UInt , type : InformationTypes , completion : @escaping NumberInfoCompletionHandler) {
        switch type {
        case .math:
            makeGetCall(urlString: URLCreator.math(number: number) , completion: completion)
            break
        case .trivia:
            makeGetCall(urlString: URLCreator.trivia(number: number), completion: completion)
            break
        case .year:
            makeGetCall(urlString: URLCreator.year(number: number), completion: completion)
            break
        }
    }
    
    static func getDateInformation(day : UInt8, month : UInt8 , completion : @escaping NumberInfoCompletionHandler) {
        makeGetCall(urlString: URLCreator.date(day: day, month: month), completion: completion)
    }
    
    static func makeGetCall(urlString : String , completion : @escaping NumberInfoCompletionHandler) {

        guard let url = URL(string: urlString) else {
            print("Error: cannot create URL")
            return
        }
        
        let urlRequest = URLRequest(url: url)
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let task = session.dataTask(with: urlRequest) {
            (data, response, error) in
            
            guard error == nil else {
                completion(false , nil)
                return
            }
            
            guard let responseData = data else {
                completion(false , nil)
                return
            }
            
            do {
                let response = try JSONDecoder().decode(NumberInfo.self, from: responseData)
                completion(true , response)
            } catch  {
                completion(false , nil)
                return
            }
        }
        task.resume()
    }

    
}
