//
//  Onboarding_1_Cell.swift
//  Big Brain Team
//
//  Created by Nick Oltyan on 08.10.2021.
//

import UIKit

class Onboarding_1_Cell: UICollectionViewCell {
    
    let loginLabel: UILabel = {
        let label = UILabel()
            .with(autolayout: false)
            .with(color: Colors.blue)
            .with(alignment: .right)
            .with(numberOfLines: 0)
            .with(fontName: "HelveticaNeue", size: 19)
        label.text = "Войти"
        return label
    }()
    
    let image: UIImageView = {
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 250, height: 250))
            .with(autolayout: false)
        image.image = UIImage(named: "onboarding_1")
        return image
    }()
    
    let title: UILabel = {
        let label = UILabel()
            .with(autolayout: false)
            .with(color: Colors.textPrimary)
            .with(alignment: .left)
            .with(numberOfLines: 0)
            .with(fontName: "HelveticaNeue-Bold", size: 28)
        label.text = "Научись собирать инвестиционный портфель"
        return label
    }()
    
    let subtitle: UILabel = {
        let label = UILabel()
            .with(autolayout: false)
            .with(color: Colors.textSecondary)
            .with(alignment: .left)
            .with(numberOfLines: 0)
            .with(fontName: "HelveticaNeue-Medium", size: 18)
        label.text = "Справишься — подарим акцию до 30 000 ₽ в ВТБ Инвестициях"
        return label
    }()
    
    let startButton: UIButton = {
        let button = UIButton()
            .with(autolayout: false)
            .with(bgColor: Colors.blue)
            .with(cornerRadius: 24)
        
        button.titleLabel?.font = UIFont(name: "HelveticaNeue", size: 16)
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Начать", for: .normal)
        return button
    }()
    
    let activateCodeButton: UIButton = {
        let button = UIButton()
            .with(autolayout: false)
            .with(bgColor: Colors.accent)
            .with(cornerRadius: 24)
        
        button.titleLabel?.font = UIFont(name: "HelveticaNeue", size: 16)
        button.setTitleColor(Colors.blue, for: .normal)
        button.setTitle("У меня есть код", for: .normal)
        return button
    }()
    
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
    
    
    @objc
    func startAction() {
        startButton.tap(completion: {_ in
            self.delegate?.next(slide: 1)
        })
    }
    
    @objc
    func codeAction() {
        
    }
}








extension Onboarding_1_Cell {
    private
    func setSubviews() {
        self.addSubview(loginLabel)
        self.addSubview(image)
        self.addSubview(title)
        self.addSubview(subtitle)
        self.addSubview(startButton)
        self.addSubview(activateCodeButton)
        
        startButton.addTarget(self, action: #selector(startAction), for: .touchUpInside)
        activateCodeButton.addTarget(self, action: #selector(codeAction), for: .touchUpInside)
    }
    
    private
    func activateLayouts() {
        NSLayoutConstraint.activate([
            loginLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 56),
            loginLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
            
            image.topAnchor.constraint(equalTo: self.topAnchor, constant: 114),
            image.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            image.heightAnchor.constraint(equalToConstant: image.frame.height),
            image.widthAnchor.constraint(equalToConstant: image.frame.width),
            
            activateCodeButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -50),
            activateCodeButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 24),
            activateCodeButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -24),
            activateCodeButton.heightAnchor.constraint(equalToConstant: 56),
            
            startButton.bottomAnchor.constraint(equalTo: activateCodeButton.topAnchor, constant: -12),
            startButton.leftAnchor.constraint(equalTo: activateCodeButton.leftAnchor),
            startButton.rightAnchor.constraint(equalTo: activateCodeButton.rightAnchor),
            startButton.heightAnchor.constraint(equalToConstant: 56),
            
            subtitle.bottomAnchor.constraint(equalTo: startButton.topAnchor, constant: -40),
            subtitle.leftAnchor.constraint(equalTo: activateCodeButton.leftAnchor),
            subtitle.rightAnchor.constraint(equalTo: activateCodeButton.rightAnchor, constant: -50),
            
            title.bottomAnchor.constraint(equalTo: subtitle.topAnchor, constant: -20),
            title.leftAnchor.constraint(equalTo: activateCodeButton.leftAnchor),
            title.rightAnchor.constraint(equalTo: activateCodeButton.rightAnchor)
        ])
    }
}
