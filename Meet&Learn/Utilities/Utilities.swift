//
//  Utilities.swift
//  Meet&Learn
//
//  Created by Ahmed Tarek on 12/1/20.
//  Copyright © 2020 Ahmed Tarek. All rights reserved.
//

import Foundation

class Utilities {
    
    static func isPasswordValid(_ password : String) -> Bool {
        
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
    
}
