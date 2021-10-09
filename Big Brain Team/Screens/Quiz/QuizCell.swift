//
//  QuizCell.swift
//  Big Brain Team
//
//  Created by Никита Олтян on 09.10.2021.
//

import UIKit

class QuizCell: UICollectionViewCell {
    
    let title: UILabel = {
        let label = UILabel()
            .with(autolayout: false)
            .with(color: Colors.textPrimary)
            .with(alignment: .left)
            .with(numberOfLines: 1)
            .with(fontName: "HelveticaNeue-Medium", size: 17)
        label.text = "Facebook, Inc."
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
            title.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            title.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16)
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
        title.textColor = Colors.textPrimary
        self.layer.borderColor = UIColor.black.withAlphaComponent(0.08).cgColor
    }
    
}
