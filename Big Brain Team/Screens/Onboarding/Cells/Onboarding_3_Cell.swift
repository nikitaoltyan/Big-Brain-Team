//
//  Onboarding_3_Cell.swift
//  Big Brain Team
//
//  Created by Nick Oltyan on 08.10.2021.
//

import UIKit

class Onboarding_3_Cell: UICollectionViewCell {
    
    var delegate: onbordingDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setSubviews()
        activateLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
}









extension Onboarding_3_Cell {
    private
    func setSubviews() {
        
    }
    
    private
    func activateLayouts() {
        NSLayoutConstraint.activate([
            
        ])
    }
}
