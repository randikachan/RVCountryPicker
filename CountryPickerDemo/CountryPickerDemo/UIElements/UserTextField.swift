//
//  UserTextField.swift
//  lifemeter-ios-swift
//
//  Created by Randika Chandrapala on 6/27/18.
//  Copyright © 2018 HackerPunch. All rights reserved.
//

import UIKit

@IBDesignable
class UserTextField: UITextField {

    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.borderColor = UIColor(red:0.85, green:0.85, blue:0.85, alpha:1.0).cgColor
        self.layer.borderWidth = 1
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 11, dy: 7)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return textRect(forBounds: bounds)
    }
    
}
