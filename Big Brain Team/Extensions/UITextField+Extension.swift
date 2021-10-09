//
//  UITextField+Extension.swift
//  Big Brain Team
//
//  Created by Nick Oltyan on 09.10.2021.
//

import Foundation
import UIKit

extension UITextField {
    
    func with(fontName: String, size: CGFloat) -> Self {
        font = UIFont(name: fontName, size: size)
        return self
    }
    
    
    func with(keybordType: UIKeyboardType) -> Self {
        self.keyboardType = keyboardType
        return self
    }
    
    
    func with(color: UIColor) -> Self {
        textColor = color
        return self
    }
    
    
    func with(placeholder: String) -> Self {
        self.placeholder = placeholder
        return self
    }
}
