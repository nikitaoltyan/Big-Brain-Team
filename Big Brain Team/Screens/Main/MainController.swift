//
//  MainController.swift
//  Big Brain Team
//
//  Created by Nick Oltyan on 08.10.2021.
//

import UIKit

class MainController: UIViewController {
    
    let moneyLabel: UILabel = {
        let label = UILabel()
            .with(autolayout: false)
            .with(color: Colors.textPrimary)
            .with(alignment: .center)
            .with(numberOfLines: 1)
            .with(fontName: "HelveticaNeue-Medium", size: 28)
        label.text = "100 000 ₽"
        return label
    }()

    let progressLabel: UILabel = {
        let label = UILabel()
            .with(autolayout: false)
            .with(color: .red)
            .with(alignment: .center)
            .with(numberOfLines: 1)
            .with(fontName: "HelveticaNeue", size: 15)
        label.text = "– 9 712 ₽ (9,7 %)"
        return label
    }()
    
    let quizView: QuizView = {
        let view = QuizView()
            .with(autolayout: false)
        return view
    }()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.primary1
        setSubviews()
        activateLayouts()
    }

}







extension MainController {
    private
    func setSubviews() {
        view.addSubview(moneyLabel)
        view.addSubview(progressLabel)
        view.addSubview(quizView)
    }
    
    private
    func activateLayouts() {
        NSLayoutConstraint.activate([
            moneyLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 73),
            moneyLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            progressLabel.topAnchor.constraint(equalTo: moneyLabel.bottomAnchor, constant: 6),
            progressLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            quizView.topAnchor.constraint(equalTo: progressLabel.bottomAnchor, constant: 24),
            quizView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            quizView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            quizView.heightAnchor.constraint(equalToConstant: quizView.frame.height)
        ])
    }
}
