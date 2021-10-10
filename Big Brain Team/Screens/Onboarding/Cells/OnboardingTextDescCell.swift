//
//  OnboardingTextDescCell.swift
//  Big Brain Team
//
//  Created by Nick Oltyan on 10.10.2021.
//

import UIKit

class OnboardingTextDescCell: UICollectionViewCell {
    
    let title: UILabel = {
        let label = UILabel()
            .with(autolayout: false)
            .with(color: Colors.textPrimary)
            .with(alignment: .left)
            .with(numberOfLines: 1)
            .with(fontName: "HelveticaNeue-Medium", size: 18)
        return label
    }()
    
    let subtitle: UILabel = {
        let label = UILabel()
            .with(autolayout: false)
            .with(color: Colors.textSecondary)
            .with(alignment: .left)
            .with(numberOfLines: 0)
            .with(fontName: "HelveticaNeue", size: 14)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = Colors.primary1
        self.layer.cornerRadius = 20
        self.layer.borderColor = UIColor.black.withAlphaComponent(0.08).cgColor
        self.layer.borderWidth = 1
        
        setSubviews()
        activateLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func select() {
        Vibration.soft()
        title.textColor = Colors.blue
        self.layer.borderColor = Colors.blue.cgColor
    }
    
    func unselect() {
        title.textColor = Colors.textSecondary
        self.layer.borderColor = UIColor.black.withAlphaComponent(0.08).cgColor
    }
}






extension OnboardingTextDescCell {
    private
    func setSubviews() {
        self.addSubview(title)
        self.addSubview(subtitle)
    }
    
    private
    func activateLayouts() {
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: self.topAnchor, constant: 12),
            title.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            title.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
            title.widthAnchor.constraint(equalToConstant: MainConstants.screenWidth-76),
            
            subtitle.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 5),
            subtitle.leftAnchor.constraint(equalTo: title.leftAnchor),
            subtitle.rightAnchor.constraint(equalTo: title.rightAnchor),
            subtitle.widthAnchor.constraint(equalToConstant: MainConstants.screenWidth-76), // 36*2
            subtitle.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -12)
        ])
    }
}
