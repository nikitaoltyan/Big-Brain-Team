//
//  OnboardingTextCell.swift
//  Big Brain Team
//
//  Created by Nick Oltyan on 09.10.2021.
//

import UIKit

class OnboardingTextCell: UICollectionViewCell {
    
    
    let title: UILabel = {
        let label = UILabel()
            .with(autolayout: false)
            .with(color: Colors.textSecondary)
            .with(alignment: .center)
            .with(numberOfLines: 1)
            .with(fontName: "HelveticaNeue-Medium", size: 18)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = Colors.primary1
        self.layer.cornerRadius = 20
        self.layer.borderColor = UIColor.black.withAlphaComponent(0.08).cgColor
        self.layer.borderWidth = 1
        
        self.addSubview(title)
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: self.topAnchor, constant: 9),
            title.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -9),
            title.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            title.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func select() {
        title.textColor = Colors.blue
        self.layer.borderColor = Colors.blue.cgColor
    }
    
    func unselect() {
        title.textColor = Colors.textSecondary
        self.layer.borderColor = UIColor.black.withAlphaComponent(0.08).cgColor
    }
}
