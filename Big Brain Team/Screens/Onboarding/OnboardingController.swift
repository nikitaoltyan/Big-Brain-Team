//
//  ViewController.swift
//  Big Brain Team
//
//  Created by Nick Oltyan on 08.10.2021.
//

import UIKit

protocol onbordingDelegate {
    func next(slide: Int)
    func finish()
    func addInterest(_ interest: String)
    func addShare(_ share: [String])
    func addPhone(_ phoneNumber: String)
    func endEditing()
}


class OnboardingController: UIViewController {
    
    let analytic = ServerAnalytics()
    
    lazy var collection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
            .with(autolayout: false)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        collection.isPagingEnabled = false
        collection.isScrollEnabled = false
//        collection.backgroundColor = Colors.background
        collection.showsHorizontalScrollIndicator = false
        collection.delegate = self
        collection.dataSource = self
        
        collection.register(Onboarding_1_Cell.self, forCellWithReuseIdentifier: "Onboarding_1_Cell")
        collection.register(Onboarding_2_Cell.self, forCellWithReuseIdentifier: "Onboarding_2_Cell")
        collection.register(Onboarding_3_Cell.self, forCellWithReuseIdentifier: "Onboarding_3_Cell")
        collection.register(Onboarding_4_Cell.self, forCellWithReuseIdentifier: "Onboarding_4_Cell")
        collection.register(Onboarding_5_Cell.self, forCellWithReuseIdentifier: "Onboarding_5_Cell")
        collection.register(Onboarding_6_Cell.self, forCellWithReuseIdentifier: "Onboarding_6_Cell")
        
        return collection
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        analytic.logStartOnboarding()
        hideKeyboardWhenTappedAround()
        view.backgroundColor = Colors.primary1
        setSubviews()
        activateLayouts()
    }


}






extension OnboardingController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: MainConstants.screenWidth, height: MainConstants.screenHeight)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.row {
        case 0:
            let cell = collection.dequeueReusableCell(withReuseIdentifier: "Onboarding_1_Cell", for: indexPath) as! Onboarding_1_Cell
            cell.delegate = self
            return cell
        case 1:
            let cell = collection.dequeueReusableCell(withReuseIdentifier: "Onboarding_2_Cell", for: indexPath) as! Onboarding_2_Cell
            cell.delegate = self
            return cell
        case 2:
            let cell = collection.dequeueReusableCell(withReuseIdentifier: "Onboarding_3_Cell", for: indexPath) as! Onboarding_3_Cell
            cell.delegate = self
            return cell
        case 3:
            let cell = collection.dequeueReusableCell(withReuseIdentifier: "Onboarding_4_Cell", for: indexPath) as! Onboarding_4_Cell
            cell.delegate = self
            return cell
        case 4:
            let cell = collection.dequeueReusableCell(withReuseIdentifier: "Onboarding_5_Cell", for: indexPath) as! Onboarding_5_Cell
            cell.delegate = self
            return cell
        default: // case 6
            let cell = collection.dequeueReusableCell(withReuseIdentifier: "Onboarding_6_Cell", for: indexPath) as! Onboarding_6_Cell
            cell.delegate = self
            return cell
        }
    }
    
}





extension OnboardingController: onbordingDelegate {
    func next(slide: Int) {
        Vibration.soft()
        collection.isPagingEnabled = true
        let indexPath = IndexPath(item: slide, section: 0)
        collection.scrollToItem(at: indexPath, at: .right, animated: true)
        collection.isPagingEnabled = false
        collection.reloadItems(at: [IndexPath(item: slide, section: 0)])
    }
    
    func finish() {
        analytic.logFinishOnboarding()
        UserDefaults.standard.set(true, forKey: "hasLaunched")
        let newVC = MainController()
        newVC.modalPresentationStyle = .fullScreen
        present(newVC, animated: true, completion: nil)
    }
    
    func addInterest(_ interest: String) {
        // TODO:
        // Add interest
    }
    
    func addShare(_ share: [String]) {
        // TODO:
        // Add share
    }
    
    func addPhone(_ phoneNumber: String) {
        // TODO:
        // Add phone number
    }
    
    func endEditing() {
        view.endEditing(true)
    }
}











extension OnboardingController {
    private
    func setSubviews(){
        view.addSubview(collection)
    }
    
    private
    func activateLayouts(){
        NSLayoutConstraint.activate([
            collection.topAnchor.constraint(equalTo: view.topAnchor),
            collection.leftAnchor.constraint(equalTo: view.leftAnchor),
            collection.rightAnchor.constraint(equalTo: view.rightAnchor),
            collection.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

