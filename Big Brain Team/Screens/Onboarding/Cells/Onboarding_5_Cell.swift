//
//  Onboarding_3_Cell.swift
//  Big Brain Team
//
//  Created by Nick Oltyan on 08.10.2021.
//

import UIKit

class Onboarding_5_Cell: UICollectionViewCell {
    
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
        label.text = "Выбери 5 акций для портфеля"
        return label
    }()
    
    lazy var collection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
            .with(autolayout: false)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 16
        
        collection.isPagingEnabled = false
        collection.isScrollEnabled = false
        collection.backgroundColor = .clear
        collection.showsHorizontalScrollIndicator = false
        collection.delegate = self
        collection.dataSource = self
        
        collection.register(OnboardingStockCell.self, forCellWithReuseIdentifier: "OnboardingStockCell")
        
        return collection
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
    
//    let shareName: [String] = ["Appl"]
//    let
    
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
//            self.delegate?.addShare(<#T##share: Int##Int#>)
            self.delegate?.next(slide: 5)
        })
    }
    
    @objc
    func backAction() {
        backButton.tap(completion: { _ in
            self.delegate?.next(slide: 3)
        })
    }
}






extension Onboarding_5_Cell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: MainConstants.screenWidth-50, height: 68)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collection.dequeueReusableCell(withReuseIdentifier: "OnboardingStockCell", for: indexPath) as! OnboardingStockCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        Vibration.soft()
        if let cell = collection.cellForItem(at: currentSelectedIndexPath ?? indexPath) as? OnboardingStockCell {
            cell.unselect()
        }
        
        if let cell = collection.cellForItem(at: indexPath) as? OnboardingStockCell {
            cell.select()
            isButtonActive = true
            nextButton.alpha = 1
            // TODO:
            // Add here some action for selected answer.
            currentSelectedIndexPath = indexPath
        }
    }
    
}








extension Onboarding_5_Cell {
    private
    func setSubviews() {
        self.addSubview(backButton)
        self.addSubview(title)
        self.addSubview(collection)
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
            
            collection.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 32),
            collection.leftAnchor.constraint(equalTo: title.leftAnchor, constant: -4),
            collection.rightAnchor.constraint(equalTo: title.rightAnchor, constant: 4),
            collection.heightAnchor.constraint(equalToConstant: 400),
            
            nextButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -50),
            nextButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 24),
            nextButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -24),
            nextButton.heightAnchor.constraint(equalToConstant: 56),
        ])
    }
}