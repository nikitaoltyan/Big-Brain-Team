//
//  QuizEndController.swift
//  Big Brain Team
//
//  Created by Nick Oltyan on 09.10.2021.
//

import UIKit

class QuizEndController: UIViewController {
    
    let analytic = ServerAnalytics()
    
    let currentMoney: UILabel = {
        let label = UILabel()
            .with(autolayout: false)
            .with(color: Colors.negative)
            .with(alignment: .center)
            .with(numberOfLines: 1)
            .with(fontName: "HelveticaNeue-Medium", size: 20)
        label.text = "0 ₽"
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
        image.image = UIImage(named: "duck")
        return image
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
            .with(autolayout: false)
            .with(color: Colors.textPrimary)
            .with(alignment: .left)
            .with(numberOfLines: 0)
            .with(fontName: "HelveticaNeue-Bold", size: 28)
        label.text = "Ты проиграл, потеряв \(Defaults().getStartBalance()) ₽"
        return label
    }()
    
    let subtitle: UILabel = {
        let label = UILabel()
            .with(autolayout: false)
            .with(color: Colors.textSecondary)
            .with(alignment: .left)
            .with(numberOfLines: 0)
            .with(fontName: "HelveticaNeue-Medium", size: 18)
        label.text = "Но у тебя есть ещё 5 попыток, чтобы получить акцию в подарок"
        return label
    }()
    
    let restartButton: UIButton = {
        let button = UIButton()
            .with(autolayout: false)
            .with(bgColor: Colors.blue)
            .with(cornerRadius: 24)
        
        button.titleLabel?.font = UIFont(name: "HelveticaNeue", size: 16)
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Попробовать еще", for: .normal)
        return button
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.primary1
        setSubviews()
        activateLayout()
    }
    
    
    @objc
    func openEducation() {
        educationBook.tap(completion: { _ in
            guard let url = URL(string: "https://broker.vtb.ru/learning/azbuka/") else { return }
            UIApplication.shared.open(url)
        })
    }
    
    @objc
    func restartAction() {
        Vibration.soft()
        analytic.logRestart()
        restartButton.tap(completion: { _ in
            let newVC = QuizController()
            newVC.modalPresentationStyle = .fullScreen
            self.present(newVC, animated: true, completion: nil)
        })
    }
}








extension QuizEndController {
    private
    func setSubviews() {
        view.addSubview(currentMoney)
        view.addSubview(balanceLabel)
        view.addSubview(educationBook)
        view.addSubview(image)
        view.addSubview(titleLabel)
        view.addSubview(subtitle)
        view.addSubview(restartButton)
        
        restartButton.addTarget(self, action: #selector(restartAction), for: .touchUpInside)
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
            
            image.topAnchor.constraint(equalTo: educationBook.bottomAnchor, constant: 95),
            image.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            image.heightAnchor.constraint(equalToConstant: image.frame.height),
            image.widthAnchor.constraint(equalToConstant: image.frame.width),
            
            restartButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            restartButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24),
            restartButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24),
            restartButton.heightAnchor.constraint(equalToConstant: 56),
            
            subtitle.bottomAnchor.constraint(equalTo: restartButton.topAnchor, constant: -40),
            subtitle.leftAnchor.constraint(equalTo: restartButton.leftAnchor),
            subtitle.rightAnchor.constraint(equalTo: restartButton.rightAnchor),
            
            titleLabel.bottomAnchor.constraint(equalTo: subtitle.topAnchor, constant: -12),
            titleLabel.leftAnchor.constraint(equalTo: restartButton.leftAnchor),
            titleLabel.rightAnchor.constraint(equalTo: restartButton.rightAnchor)
        ])
    }
}
