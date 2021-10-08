//
//  Onboarding_2_Cell.swift
//  Big Brain Team
//
//  Created by Nick Oltyan on 08.10.2021.
//

import UIKit

class Onboarding_2_Cell: UICollectionViewCell {
    
//    let closeButton: UIButton = {
//        
//    }()
//    
//    lazy var collection: UICollectionView = {
//        let layout = UICollectionViewFlowLayout()
//        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
//            .with(autolayout: false)
//        layout.scrollDirection = .horizontal
//        layout.minimumLineSpacing = 0
//        layout.minimumInteritemSpacing = 0
//        
//        collection.isPagingEnabled = false
//        collection.isScrollEnabled = false
////        collection.backgroundColor = Colors.background
//        collection.showsHorizontalScrollIndicator = false
//        collection.delegate = self
//        collection.dataSource = self
//        
//        collection.register(Onboarding_1_Cell.self, forCellWithReuseIdentifier: "Onboarding_1_Cell")
//        collection.register(Onboarding_2_Cell.self, forCellWithReuseIdentifier: "Onboarding_2_Cell")
//        collection.register(Onboarding_3_Cell.self, forCellWithReuseIdentifier: "Onboarding_3_Cell")
//        collection.register(Onboarding_4_Cell.self, forCellWithReuseIdentifier: "Onboarding_4_Cell")
//        
//        return collection
//    }()
//    
//    let nextButton: UIButton = {
//        let button = UIButton()
//            .with(autolayout: false)
//            .with(bgColor: .lightGray)
//            .with(cornerRadius: 12)
//        
//        button.titleLabel?.font = UIFont(name: "SFPro", size: 17)
//        button.setTitleColor(.white, for: .normal)
//        button.setTitle("Есть код", for: .normal)
//        return button
//    }()
    
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
    
}









extension Onboarding_2_Cell {
    private
    func setSubviews() {
        
    }
    
    private
    func activateLayouts() {
        NSLayoutConstraint.activate([
            
        ])
    }
}
