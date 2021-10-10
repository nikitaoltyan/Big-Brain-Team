//
//  QuizWinController.swift
//  Big Brain Team
//
//  Created by Nick Oltyan on 09.10.2021.
//

import UIKit
import Lottie

class QuizWinController: UIViewController {
    
    let analytic = ServerAnalytics()
    
    let currentMoney: UILabel = {
        let label = UILabel()
            .with(autolayout: false)
            .with(color: Colors.positive)
            .with(alignment: .center)
            .with(numberOfLines: 1)
            .with(fontName: "HelveticaNeue-Medium", size: 20)
        label.text = "150 000 ₽"
        return label
    }()
    
    let balanceLabel: UILabel = {
        let label = UILabel()
            .with(autolayout: false)
            .with(color: Colors.textSecondary)
            .with(alignment: .center)
            .with(numberOfLines: 1)
            .with(fontName: "HelveticaNeue", size: 15)
        label.text = "Баланс"
        return label
    }()
    
    let educationBook: UILabel = {
        let label = UILabel()
            .with(autolayout: false)
            .with(color: Colors.blue)
            .with(alignment: .right)
            .with(numberOfLines: 1)
            .with(fontName: "HelveticaNeue", size: 17)
        label.isUserInteractionEnabled = true
        label.text = "Учебник"
        return label
    }()
    
    let image: UIImageView = {
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 250, height: 250))
            .with(autolayout: false)
        image.image = UIImage(named: "gift")
        return image
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
            .with(autolayout: false)
            .with(color: Colors.textPrimary)
            .with(alignment: .left)
            .with(numberOfLines: 0)
            .with(fontName: "HelveticaNeue-Bold", size: 28)
        label.text = "Ты выиграл акцию в ВТБ Инвестициях"
        return label
    }()
    
    let subtitle: UILabel = {
        let label = UILabel()
            .with(autolayout: false)
            .with(color: Colors.textSecondary)
            .with(alignment: .left)
            .with(numberOfLines: 0)
            .with(fontName: "HelveticaNeue-Medium", size: 18)
        label.text = "Пригласи друга в игру и получи ещё одну акцию в подарок"
        return label
    }()
    
    let openAppButton: UIButton = {
        let button = UIButton()
            .with(autolayout: false)
            .with(bgColor: Colors.blue)
            .with(cornerRadius: 24)
        
        button.titleLabel?.font = UIFont(name: "HelveticaNeue", size: 16)
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Перейти в ВТБ Инвестиции", for: .normal)
        return button
    }()
    
    let shareButton: UIButton = {
        let button = UIButton()
            .with(autolayout: false)
            .with(bgColor: Colors.accent)
            .with(cornerRadius: 24)
        
        button.titleLabel?.font = UIFont(name: "HelveticaNeue", size: 16)
        button.setTitleColor(Colors.blue, for: .normal)
        button.setTitle("Пригласить друга", for: .normal)
        return button
    }()
    
    lazy var animation: AnimationView = {
        let animation = AnimationView(name: "confetti")
        animation.frame = view.bounds
        animation.contentMode = .scaleAspectFit
        animation.loopMode = .playOnce
        animation.animationSpeed = 2
        return animation
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.primary1
        setSubviews()
        activateLayout()
        
        view.addSubview(animation)
        animation.play(completion: {_ in
            self.animation.removeFromSuperview()
        })
    }

    
    @objc
    func openAppAction() {
        openAppButton.tap(completion: { _ in
            if let url = URL(string: "itms-apps://apple.com/app/id1364026756") {
                UIApplication.shared.open(url)
            }
        })
    }
    
    @objc
    func shareAction() {
        shareButton.tap(completion: { _ in
            
        })
    }
}








extension QuizWinController {
    private
    func setSubviews() {
        view.addSubview(currentMoney)
        view.addSubview(balanceLabel)
        view.addSubview(educationBook)
        view.addSubview(image)
        view.addSubview(titleLabel)
        view.addSubview(subtitle)
        view.addSubview(openAppButton)
        view.addSubview(shareButton)
        
        openAppButton.addTarget(self, action: #selector(openAppAction), for: .touchUpInside)
        shareButton.addTarget(self, action: #selector(shareAction), for: .touchUpInside)
    }
    
    private
    func activateLayout() {
        NSLayoutConstraint.activate([
            currentMoney.topAnchor.constraint(equalTo: view.topAnchor, constant: 46),
            currentMoney.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            balanceLabel.topAnchor.constraint(equalTo: currentMoney.bottomAnchor, constant: 2),
            balanceLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            educationBook.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -13),
            educationBook.topAnchor.constraint(equalTo: view.topAnchor, constant: 55),
            
            image.topAnchor.constraint(equalTo: educationBook.bottomAnchor, constant: 90),
            image.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            image.heightAnchor.constraint(equalToConstant: image.frame.height),
            image.widthAnchor.constraint(equalToConstant: image.frame.width),
            
            shareButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            shareButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24),
            shareButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24),
            shareButton.heightAnchor.constraint(equalToConstant: 56),
            
            openAppButton.bottomAnchor.constraint(equalTo: shareButton.topAnchor, constant: -12),
            openAppButton.leftAnchor.constraint(equalTo: shareButton.leftAnchor),
            openAppButton.rightAnchor.constraint(equalTo: shareButton.rightAnchor),
            openAppButton.heightAnchor.constraint(equalToConstant: 56),
            
            subtitle.bottomAnchor.constraint(equalTo: openAppButton.topAnchor, constant: -40),
            subtitle.leftAnchor.constraint(equalTo: shareButton.leftAnchor),
            subtitle.rightAnchor.constraint(equalTo: shareButton.rightAnchor),
            
            titleLabel.bottomAnchor.constraint(equalTo: subtitle.topAnchor, constant: -12),
            titleLabel.leftAnchor.constraint(equalTo: shareButton.leftAnchor),
            titleLabel.rightAnchor.constraint(equalTo: shareButton.rightAnchor)
        ])
    }
}





