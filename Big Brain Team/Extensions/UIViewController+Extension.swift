//
//  UIViewController+Extension.swift
//  Big Brain Team
//
//  Created by Nick Oltyan on 08.10.2021.
//

import Foundation
import UIKit



extension UIViewController {
    
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    
    @objc
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
    func prepareAlert(withTitle title: String?, andSubtitle subtitle: String?, closeAction close: String) -> UIAlertController {
        Vibration.soft()
        let alert = UIAlertController(title: title,
                                      message: subtitle,
                                      preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: close,
                                      style: .cancel,
                                      handler: { (_) in }))

        return alert
    }
}

