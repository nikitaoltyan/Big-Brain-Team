//
//  Onboarding_6_Cell.swift
//  Big Brain Team
//
//  Created by Nick Oltyan on 09.10.2021.
//



import UIKit

class Onboarding_4_Cell: UICollectionViewCell {
    
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
        label.text = "Твой ежемесячный доход?"
        return label
    }()
    
    let subtitle: UILabel = {
        let label = UILabel()
            .with(autolayout: false)
            .with(color: Colors.textSecondary)
            .with(alignment: .left)
            .with(numberOfLines: 0)
            .with(fontName: "HelveticaNeue-Medium", size: 18)
        label.text = "С этой цифрой игра будет реалистичнее для тебя"
        return label
    }()
    
    lazy var collection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
            .with(autolayout: false)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 12
        layout.minimumInteritemSpacing = 16
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        
        collection.isPagingEnabled = false
        collection.isScrollEnabled = false
        collection.backgroundColor = .clear
        collection.showsHorizontalScrollIndicator = false
        collection.delegate = self
        collection.dataSource = self
        
        collection.register(OnboardingTextCell.self, forCellWithReuseIdentifier: "OnboardingTextCell")
        
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
    
    
    let cells = ["До 20 000 ₽", "20 001 ₽ – 50 000 ₽", "50 001 – 100 000 ₽ ", "100 001 ₽ — 150 000 ₽", "150 001 ₽ — 200 000 ₽", "Больше 200 000 ₽"]
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
            let index = self.currentSelectedIndexPath?.row ?? 0
            switch index {
            case 1: self.delegate?.addBalance(35000)
            case 2: self.delegate?.addBalance(75000)
            case 3: self.delegate?.addBalance(125000)
            case 4: self.delegate?.addBalance(175000)
            case 5: self.delegate?.addBalance(200000)
            default: self.delegate?.addBalance(20000)
            }
            self.delegate?.next(slide: 4)
        })
    }
    
    @objc
    func backAction() {
        backButton.tap(completion: { _ in
            self.delegate?.next(slide: 2)
        })
    }
}






extension Onboarding_4_Cell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cells.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collection.dequeueReusableCell(withReuseIdentifier: "OnboardingTextCell", for: indexPath) as! OnboardingTextCell
        cell.title.text = cells[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        Vibration.soft()
        if let cell = collection.cellForItem(at: currentSelectedIndexPath ?? indexPath) as? OnboardingTextCell {
            cell.unselect()
        }
        
        if let cell = collection.cellForItem(at: indexPath) as? OnboardingTextCell {
            cell.select()
            isButtonActive = true
            nextButton.alpha = 1
            // TODO:
            // Add here some action for selected answer.
            currentSelectedIndexPath = indexPath
        }
    }
    
}






extension Onboarding_4_Cell {
    private
    func setSubviews() {
        self.addSubview(backButton)
        self.addSubview(title)
        self.addSubview(subtitle)
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
            
            subtitle.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 15),
            subtitle.leftAnchor.constraint(equalTo: title.leftAnchor),
            subtitle.rightAnchor.constraint(equalTo: title.rightAnchor),
            
            collection.topAnchor.constraint(equalTo: subtitle.bottomAnchor, constant: 31),
            collection.leftAnchor.constraint(equalTo: title.leftAnchor),
            collection.rightAnchor.constraint(equalTo: title.rightAnchor),
            collection.heightAnchor.constraint(equalToConstant: 400),
            
            nextButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -50),
            nextButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 24),
            nextButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -24),
            nextButton.heightAnchor.constraint(equalToConstant: 56),
        ])
    }
}
