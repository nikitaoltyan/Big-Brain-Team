//
//  Onboarding_4_Cell.swift
//  Big Brain Team
//
//  Created by Nick Oltyan on 08.10.2021.
//

import UIKit

class Onboarding_6_Cell: UICollectionViewCell {
    
    let backButton: UIImageView = {
        let button = UIImageView(frame: CGRect(x: 0, y: 0, width: 24, height: 29))
            .with(autolayout: false)
        button.tintColor = Colors.blue
        button.image = UIImage(systemName: "chevron.left")
        button.isUserInteractionEnabled = true
        return button
    }()
    
    let title: UILabel = {
        let label = UILabel()
            .with(autolayout: false)
            .with(color: Colors.textPrimary)
            .with(alignment: .left)
            .with(numberOfLines: 0)
            .with(fontName: "HelveticaNeue-Bold", size: 28)
        label.text = "Последний шаг: номер телефона"
        return label
    }()
    
    lazy var phoneField: UITextField = {
        let view = UITextField()
            .with(autolayout: false)
            .with(cornerRadius: 20)
            .with(keybordType: .phonePad)
            .with(placeholder: "+7 XXX XXX XX")
            .with(fontName: "HelveticaNeue", size: 18)
        view.delegate = self
        view.textColor = Colors.textPrimary
        view.layer.borderColor = UIColor.black.withAlphaComponent(0.08).cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    let subtitle: UILabel = {
        let label = UILabel()
            .with(autolayout: false)
            .with(color: Colors.textSecondary)
            .with(alignment: .left)
            .with(numberOfLines: 1)
            .with(fontName: "HelveticaNeue", size: 13)
        label.text = "Без номера мы не сможем подарить акцию"
        return label
    }()
    
    let nextButton: UIButton = {
        let button = UIButton()
            .with(autolayout: false)
            .with(bgColor: Colors.blue)
            .with(cornerRadius: 24)
        
        button.titleLabel?.font = UIFont(name: "HelveticaNeue", size: 16)
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Продолжить", for: .normal)
        button.alpha = 0.3
        return button
    }()
    
    
    var isButtonActive = false
    var currentSelectedIndexPath: IndexPath?
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
    func nextAction() {
        guard isButtonActive else { return }
        nextButton.tap(completion: { _ in
            self.delegate?.addPhone(self.phoneField.text ?? "NaN")
            self.delegate?.finish()
        })
    }
    
    @objc
    func backAction() {
        backButton.tap(completion: { _ in
            self.delegate?.next(slide: 4)
        })
    }
}







extension Onboarding_6_Cell: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.text?.count ?? 0 > 10 {
            isButtonActive = true
            nextButton.alpha = 1
            return true
        }
        if textField.text?.count ?? 0 < 11 {
            isButtonActive = false
            nextButton.alpha = 0.3
            return true
        } else {
            isButtonActive = true
            nextButton.alpha = 1
            self.delegate?.endEditing()
            return false
        }
    }
}






extension Onboarding_6_Cell {
    private
    func setSubviews() {
        self.addSubview(backButton)
        self.addSubview(title)
        self.addSubview(phoneField)
        self.addSubview(subtitle)
        self.addSubview(nextButton)
        
        nextButton.addTarget(self, action: #selector(nextAction), for: .touchUpInside)
        backButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(backAction)))
    }
    
    private
    func activateLayouts() {
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 55),
            backButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 12),
            backButton.heightAnchor.constraint(equalToConstant: backButton.frame.height),
            backButton.widthAnchor.constraint(equalToConstant: backButton.frame.width),
            
            title.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 25),
            title.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 24),
            title.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -24),
            
            phoneField.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 32),
            phoneField.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
            phoneField.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20),
            phoneField.heightAnchor.constraint(equalToConstant: 52),
            
            subtitle.topAnchor.constraint(equalTo: phoneField.bottomAnchor, constant: 8),
            subtitle.leftAnchor.constraint(equalTo: phoneField.leftAnchor),
            
            nextButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -50),
            nextButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 24),
            nextButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -24),
            nextButton.heightAnchor.constraint(equalToConstant: 56),
        ])
    }
}
