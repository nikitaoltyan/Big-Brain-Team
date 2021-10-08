//
//  Onboarding_1_Cell.swift
//  Big Brain Team
//
//  Created by Nick Oltyan on 08.10.2021.
//

import UIKit

class Onboarding_1_Cell: UICollectionViewCell {
    
    let title: UILabel = {
        let label = UILabel()
            .with(autolayout: false)
            .with(color: Colors.black)
            .with(alignment: .center)
            .with(numberOfLines: 0)
            .with(fontName: "SFPro-Medium", size: 25)
        label.text = "Собери портфель и получи акцию на стоимость до 30 000 ₽ от ВТБ Инвестиции"
        return label
    }()
    
    let startButton: UIButton = {
        let button = UIButton()
            .with(autolayout: false)
            .with(bgColor: Colors.blue)
            .with(cornerRadius: 12)
        
        button.titleLabel?.font = UIFont(name: "SFPro", size: 17)
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Начать", for: .normal)
        return button
    }()
    
    let activateCodeButton: UIButton = {
        let button = UIButton()
            .with(autolayout: false)
            .with(bgColor: .lightGray)
            .with(cornerRadius: 12)
        
        button.titleLabel?.font = UIFont(name: "SFPro", size: 17)
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Есть код", for: .normal)
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
        delegate?.next(slide: 1)
    }
    
    @objc
    func codeAction() {
        
    }
}








extension Onboarding_1_Cell {
    private
    func setSubviews() {
        self.addSubview(title)
        self.addSubview(startButton)
        self.addSubview(activateCodeButton)
        
        startButton.addTarget(self, action: #selector(startAction), for: .touchUpInside)
        activateCodeButton.addTarget(self, action: #selector(codeAction), for: .touchUpInside)
    }
    
    private
    func activateLayouts() {
        NSLayoutConstraint.activate([
            activateCodeButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -96),
            activateCodeButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 24),
            activateCodeButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -24),
            activateCodeButton.heightAnchor.constraint(equalToConstant: 48),
            
            startButton.bottomAnchor.constraint(equalTo: activateCodeButton.topAnchor, constant: -16),
            startButton.leftAnchor.constraint(equalTo: activateCodeButton.leftAnchor),
            startButton.rightAnchor.constraint(equalTo: activateCodeButton.rightAnchor),
            startButton.heightAnchor.constraint(equalToConstant: 48),
            
            title.bottomAnchor.constraint(equalTo: startButton.topAnchor, constant: -57),
            title.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            title.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16)
        ])
    }
}
