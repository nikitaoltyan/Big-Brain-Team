//
//  QuizCell.swift
//  Big Brain Team
//
//  Created by Никита Олтян on 09.10.2021.
//

import UIKit

class QuizCell: UICollectionViewCell {
    
    let viewBG: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 48))
            .with(autolayout: false)
            .with(bgColor: Colors.primary1)
            .with(borderWidth: 1, color: UIColor.black.withAlphaComponent(0.08).cgColor)
            .with(cornerRadius: 20)
        return view
    }()
    
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
    
    let loseLabel: UILabel = {
        let label = UILabel()
            .with(autolayout: false)
            .with(color: Colors.negative)
            .with(alignment: .left)
            .with(numberOfLines: 1)
            .with(fontName: "HelveticaNeue-Medium", size: 14)
        label.text = "Ты потерял 10 000 ₽"
        return label
    }()
    
    let loseExplainLabel: UILabel = {
        let label = UILabel()
            .with(autolayout: false)
            .with(color: Colors.textSecondary)
            .with(alignment: .left)
            .with(numberOfLines: 0)
            .with(fontName: "HelveticaNeue-Medium", size: 14)
        label.text = "Падение цены — не повод для паники. Лучше подожди роста, чтобы не уйти в минус"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = Colors.primary1
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
    
    func setCell(isCellRight right: Bool, isTapped tapped: Bool, isAnswersShown shown: Bool) {
        print("isCellRight \(right), isTapped \(tapped), isAnswersShown \(shown)")
        guard shown else {
            loseLabel.isHidden = true
            loseExplainLabel.isHidden = true
            return
        }
        
        if tapped {
            if right {
                viewBG.layer.borderColor = Colors.positive.cgColor
                title.textColor = Colors.positive
                loseLabel.isHidden = true
                loseExplainLabel.isHidden = true
            } else {
                viewBG.layer.borderColor = Colors.negative.cgColor
                title.textColor = Colors.negative
                loseLabel.isHidden = false
                loseExplainLabel.isHidden = false
            }
        } else {
            if right {
                viewBG.layer.borderColor = Colors.positive.cgColor
                title.textColor = Colors.positive
                loseLabel.isHidden = true
                loseExplainLabel.isHidden = true
            } else {
                viewBG.layer.borderColor = UIColor.black.withAlphaComponent(0.08).cgColor
                title.textColor = Colors.textPrimary
                loseLabel.isHidden = true
                loseExplainLabel.isHidden = true
            }
        }
    }
    
}





extension QuizCell {
    private
    func setSubviews() {
        self.addSubview(viewBG)
        viewBG.addSubview(title)
        self.addSubview(loseLabel)
        self.addSubview(loseExplainLabel)
    }
    
    private
    func activateLayouts() {
        NSLayoutConstraint.activate([
            viewBG.topAnchor.constraint(equalTo: self.topAnchor),
            viewBG.leftAnchor.constraint(equalTo: self.leftAnchor),
            viewBG.rightAnchor.constraint(equalTo: self.rightAnchor),
            viewBG.heightAnchor.constraint(equalToConstant: viewBG.frame.height),
            
            title.centerYAnchor.constraint(equalTo: viewBG.centerYAnchor),
            title.leftAnchor.constraint(equalTo: viewBG.leftAnchor, constant: 16),
            
            loseLabel.topAnchor.constraint(equalTo: viewBG.bottomAnchor, constant: 8),
            loseLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 3),
            
            loseExplainLabel.topAnchor.constraint(equalTo: loseLabel.bottomAnchor, constant: 5),
            loseExplainLabel.leftAnchor.constraint(equalTo: loseLabel.leftAnchor),
            loseExplainLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -3)
        ])
    }
}
