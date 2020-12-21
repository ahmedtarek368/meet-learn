//
//  File.swift
//  Meet&Learn
//
//  Created by Ahmed Tarek on 11/30/20.
//  Copyright © 2020 Ahmed Tarek. All rights reserved.
//

import Foundation
import UIKit

class Style {
    static func styleNormalButton(Button: UIButton){
        Button.layer.borderWidth = 1.3
        Button.layer.borderColor = #colorLiteral(red: 0.3874784112, green: 0.7577080131, blue: 0.3121527433, alpha: 1)
        Button.layer.cornerRadius = Button.frame.height/2.1
        Button.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        Button.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        Button.setTitleColor(#colorLiteral(red: 0.3874784112, green: 0.7577080131, blue: 0.3121527433, alpha: 1), for: .normal)
    }

    static func stylePressedButton(Button: UIButton){
        Button.layer.backgroundColor = #colorLiteral(red: 0.3874784112, green: 0.7577080131, blue: 0.3121527433, alpha: 1)
        Button.tintColor = #colorLiteral(red: 0.3874784112, green: 0.7577080131, blue: 0.3121527433, alpha: 1)
        Button.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
    }

    static func styleTextField(_ textfield:UITextField) {
        
        // Create the bottom line
        let bottomLine = CALayer()

        bottomLine.frame = CGRect(x: 0, y: textfield.frame.size.height - 2 , width: textfield.frame.width, height: 2)
        
        bottomLine.backgroundColor = #colorLiteral(red: 0.3874784112, green: 0.7577080131, blue: 0.3121527433, alpha: 1)
        textfield.layer.addSublayer(bottomLine)
        textfield.autocorrectionType = .no
        textfield.autocapitalizationType = .none
    }
    
}

