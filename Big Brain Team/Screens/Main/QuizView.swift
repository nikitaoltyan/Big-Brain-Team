//
//  QuizView.swift
//  Big Brain Team
//
//  Created by Nick Oltyan on 09.10.2021.
//

import UIKit

class QuizView: UIView {
    
    let questionLabel: UILabel = {
        let label = UILabel()
            .with(autolayout: false)
            .with(color: Colors.textPrimary)
            .with(alignment: .left)
            .with(numberOfLines: 0)
            .with(fontName: "HelveticaNeue-Medium", size: 28)
        label.text = "Стоимость акций Apple упала на 10%"
        return label
    }()
    
    let progressLabel: UILabel = {
        let label = UILabel()
            .with(autolayout: false)
            .with(color: Colors.textSecondary)
            .with(alignment: .left)
            .with(numberOfLines: 1)
            .with(fontName: "HelveticaNeue", size: 15)
        label.text = "Уровень 6 из 12"
        return label
    }()
    
    let stock: UIImageView = {
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 295, height: 121))
            .with(autolayout: false)
        image.image = UIImage(named: "stock_price")
        return image
    }()
    
    let button: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 287, height: 56))
            .with(autolayout: false)
            .with(bgColor: Colors.accent)
            .with(cornerRadius: 24)
        
        button.titleLabel?.font = UIFont(name: "HelveticaNeue", size: 16)
        button.setTitleColor(Colors.blue, for: .normal)
        button.setTitle("Что будем делать?", for: .normal)
        return button
    }()
    
    
    var delegate: mainDelegate?

    override init(frame: CGRect) {
        let useFrame = CGRect(x: 0, y: 0, width: 0, height: 318)
        super.init(frame: useFrame)
        self.backgroundColor = Colors.primary1
        self.layer.cornerRadius = 32
        self.layer.borderColor = UIColor.black.withAlphaComponent(0.08).cgColor
        self.layer.borderWidth = 1
        
        setSubviews()
        activateLayouts()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
    
    @objc
    func buttonAction() {
        button.tap(completion: { _ in
            self.delegate?.openQuiz()
        })
    }
}





extension QuizView {
    private
    func setSubviews() {
        self.addSubview(questionLabel)
        self.addSubview(progressLabel)
        self.addSubview(stock)
        self.addSubview(button)
        
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
    }
    
    private
    func activateLayouts() {
        NSLayoutConstraint.activate([
            questionLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            questionLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 24),
            questionLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -24),
            
            progressLabel.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 12),
            progressLabel.leftAnchor.constraint(equalTo: questionLabel.leftAnchor),
            
            stock.topAnchor.constraint(equalTo: progressLabel.bottomAnchor, constant: 5),
            stock.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            stock.heightAnchor.constraint(equalToConstant: stock.frame.height),
            stock.widthAnchor.constraint(equalToConstant: stock.frame.width),
            
            button.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20),
            button.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            button.heightAnchor.constraint(equalToConstant: button.frame.height),
            button.widthAnchor.constraint(equalToConstant: button.frame.width),
        ])
    }
}
