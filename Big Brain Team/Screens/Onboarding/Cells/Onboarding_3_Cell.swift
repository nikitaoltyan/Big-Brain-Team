//
//  Onboarding_5_Cell.swift
//  Big Brain Team
//
//  Created by Nick Oltyan on 09.10.2021.
//


import UIKit

class Onboarding_3_Cell: UICollectionViewCell {
    
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
        label.text = "Чего ты хочешь достичь?"
        return label
    }()
    
    lazy var collection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
            .with(autolayout: false)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 16
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        
        collection.isPagingEnabled = false
        collection.isScrollEnabled = false
        collection.backgroundColor = .clear
        collection.showsHorizontalScrollIndicator = false
        collection.delegate = self
        collection.dataSource = self
        
        collection.register(OnboardingTextDescCell.self, forCellWithReuseIdentifier: "OnboardingTextDescCell")
        
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
    
    
    let cellTitles = ["Защитить деньги от инфляции", "Накопить деньги", "Высокую доходность"]
    let cellSubtitles = ["Хочу, чтобы они не обесценивались", "Буду инвестировать все свободные средства и немного рисковать", "Готов сильно рисковать и понимаю, что могу потерять деньги"]
//    [1.07, 1.3, 1.5]
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
            switch self.currentSelectedIndexPath?.row ?? 0 {
            case 1: self.delegate?.addTarget(1.3)
            case 2: self.delegate?.addTarget(1.5)
            default: self.delegate?.addTarget(1.07)
            }
            self.delegate?.next(slide: 3)
        })
    }
    
    @objc
    func backAction() {
        backButton.tap(completion: { _ in
            self.delegate?.next(slide: 1)
        })
    }
}






extension Onboarding_3_Cell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellTitles.count
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        switch indexPath.row {
//        case 0: return CGSize(width: MainConstants.screenWidth-40, height: 66)
//        default: return CGSize(width: MainConstants.screenWidth-40, height: 82)
//        }
//    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collection.dequeueReusableCell(withReuseIdentifier: "OnboardingTextDescCell", for: indexPath) as! OnboardingTextDescCell
        cell.title.text = cellTitles[indexPath.row]
        cell.subtitle.text = cellSubtitles[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        Vibration.soft()
        if let cell = collection.cellForItem(at: currentSelectedIndexPath ?? indexPath) as? OnboardingTextDescCell {
            cell.unselect()
        }
        
        if let cell = collection.cellForItem(at: indexPath) as? OnboardingTextDescCell {
            cell.select()
            isButtonActive = true
            nextButton.alpha = 1
            // TODO:
            // Add here some action for selected answer.
            currentSelectedIndexPath = indexPath
        }
    }
    
}






extension Onboarding_3_Cell {
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
            collection.leftAnchor.constraint(equalTo: title.leftAnchor,constant: -4),
            collection.rightAnchor.constraint(equalTo: title.rightAnchor, constant: 4),
            collection.heightAnchor.constraint(equalToConstant: 400),
            
            nextButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -50),
            nextButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 24),
            nextButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -24),
            nextButton.heightAnchor.constraint(equalToConstant: 56),
        ])
    }
}
