//
//  OnboardingStockCell.swift
//  Big Brain Team
//
//  Created by Nick Oltyan on 09.10.2021.
//

import UIKit

class OnboardingStockCell: UICollectionViewCell {
    
    let image: UIImageView = {
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
            .with(autolayout: false)
            .with(cornerRadius: 44/2)
        image.image = UIImage(named: "facebook")
        return image
    }()
    
    let title: UILabel = {
        let label = UILabel()
            .with(autolayout: false)
            .with(color: Colors.textPrimary)
            .with(alignment: .left)
            .with(numberOfLines: 1)
            .with(fontName: "HelveticaNeue", size: 17)
        label.text = "Facebook, Inc."
        return label
    }()
    
    let sphereTitle: UILabel = {
        let label = UILabel()
            .with(autolayout: false)
            .with(color: Colors.textSecondary)
            .with(alignment: .left)
            .with(numberOfLines: 1)
            .with(fontName: "HelveticaNeue", size: 13)
        label.text = "технологии"
        return label
    }()
    
    let percentage: UILabel = {
        let label = UILabel()
            .with(autolayout: false)
            .with(color: Colors.textPrimary)
            .with(alignment: .right)
            .with(numberOfLines: 1)
            .with(fontName: "HelveticaNeue", size: 17)
        label.text = "20%"
        return label
    }()
    
    let arrow: UIImageView = {
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 11, height: 14))
            .with(autolayout: false)
        image.image = UIImage(systemName: "arrow.up")
        image.tintColor = Colors.green
        return image
    }()
    
    let potential: UILabel = {
        let label = UILabel()
            .with(autolayout: false)
            .with(color: Colors.textSecondary)
            .with(alignment: .right)
            .with(numberOfLines: 1)
            .with(fontName: "HelveticaNeue", size: 13)
        label.text = "потенциал"
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
        title.textColor = Colors.blue
        self.layer.borderColor = Colors.blue.cgColor
    }
    
    func unselect() {
        title.textColor = Colors.textPrimary
        self.layer.borderColor = UIColor.black.withAlphaComponent(0.08).cgColor
    }
}









extension OnboardingStockCell {
    private
    func setSubviews() {
        self.addSubview(image)
        self.addSubview(title)
        self.addSubview(sphereTitle)
        self.addSubview(percentage)
        self.addSubview(arrow)
        self.addSubview(potential)
    }
    
    private
    func activateLayouts() {
        NSLayoutConstraint.activate([
            image.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            image.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            image.heightAnchor.constraint(equalToConstant: image.frame.height),
            image.widthAnchor.constraint(equalToConstant: image.frame.width),
            
            title.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            title.leftAnchor.constraint(equalTo: image.rightAnchor, constant: 12),
            
            sphereTitle.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 5),
            sphereTitle.leftAnchor.constraint(equalTo: title.leftAnchor),
            
            percentage.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            percentage.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
            
            arrow.centerYAnchor.constraint(equalTo: percentage.centerYAnchor),
            arrow.rightAnchor.constraint(equalTo: percentage.leftAnchor, constant: -6),
            arrow.heightAnchor.constraint(equalToConstant: arrow.frame.height),
            arrow.widthAnchor.constraint(equalToConstant: arrow.frame.width),
            
            potential.topAnchor.constraint(equalTo: percentage.bottomAnchor, constant: 3),
            potential.rightAnchor.constraint(equalTo: percentage.rightAnchor)
        ])
    }
}
