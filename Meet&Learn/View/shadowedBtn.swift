//
//  shadowedBtn.swift
//  Meet&Learn
//
//  Created by Ahmed Tarek on 1/16/21.
//  Copyright © 2021 Ahmed Tarek. All rights reserved.
//

import UIKit

class shadowedBtn: UIButton {

    
    override func awakeFromNib(){
        super.awakeFromNib()
        customBtn()
    }
    
    func customBtn(){
        layer.borderWidth = 0.4
        layer.shadowRadius = 2
        layer.shadowColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize(width: 2, height: 2)
        layer.masksToBounds = false
        layer.backgroundColor = #colorLiteral(red: 0.4039215686, green: 0.7725490196, blue: 0.3137254902, alpha: 1)
        layer.cornerRadius = frame.size.height/6.2
        //clipsToBounds = true
    }
}
