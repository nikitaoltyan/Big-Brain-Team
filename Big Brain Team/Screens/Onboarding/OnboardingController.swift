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
    func addExperinece(_ exp: Int)
    func addTarget(_ target: Double)
    func addBalance(_ balance: Int)
    func addShare(_ share: [(String, ShareRisk, ShareSphere)])
    func addPhone(_ phoneNumber: String)
    func endEditing()}


class OnboardingController: UIViewController {
    
    let analytic = ServerAnalytics()
    let userDefaults = Defaults()
    
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
    
    let pager: UIPageControl = {
        let pager = UIPageControl()
            .with(bgColor: .clear)
            .with(autolayout: false)
        pager.numberOfPages = 5
        pager.currentPageIndicatorTintColor = Colors.textSecondary
        pager.pageIndicatorTintColor = Colors.textSecondary.withAlphaComponent(0.3)
        pager.isHidden = true
        return pager
    }()
    
    var shares: [(String, ShareRisk, ShareSphere)] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        analytic.logStartOnboarding()
        hideKeyboardWhenTappedAround()
        view.backgroundColor = Colors.primary1
        AppTransparency().requestPermission()
        setSubviews()
        activateLayouts()
    }


    
    private
    func preprocessAnswers(shares: [(String, ShareRisk, ShareSphere)]) -> ([Share], Portfel) {
        var riskCount = 0
        var resultShares: [Share] = []
        var spheres: Set<ShareSphere> = []
        for share in shares {
            let (name, risk, sphere) = share
            if risk == .risk { riskCount += 1}
            resultShares.append(Share(name: name, risk: risk))
            spheres.insert(sphere)
        }
        
        let divers: PortfelDiversification = {
            if shares.count == 3 {
                return .diversified
            } else {
                return .notDiversified
            }
        }()
        
        let risk: PortfelRisk = {
            if riskCount > 2 {
                return .risk
            } else {
                return .notRisk
            }
        }()
        let portfel = Portfel(divers: divers, risk: risk)
        return (resultShares, portfel)
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
        pager.currentPage = slide-1
        collection.isPagingEnabled = true
        let indexPath = IndexPath(item: slide, section: 0)
        collection.scrollToItem(at: indexPath, at: .right, animated: true)
        collection.isPagingEnabled = false
        collection.reloadItems(at: [IndexPath(item: slide, section: 0)])
        
        if slide == 0 {
            pager.isHidden = true
        } else {
            pager.isHidden = false
        }
    }
    
    func finish() {
        analytic.logFinishOnboarding()
        UserDefaults.standard.set(true, forKey: "hasLaunched")
        let newVC = QuizController()
        newVC.modalPresentationStyle = .fullScreen
        let (shares, portfel) = preprocessAnswers(shares: self.shares)
        newVC.shares = shares
        newVC.portfel = portfel
        present(newVC, animated: true, completion: nil)
    }
    
    func addExperinece(_ exp: Int) {
        userDefaults.setExpirience(exp)
    }
    
    func addBalance(_ balance: Int) {
        userDefaults.setStartBalance(balance)
    }
    
    func addTarget(_ target: Double) {
        userDefaults.setWinningTarget(target)
    }
    
    func addShare(_ share: [(String, ShareRisk, ShareSphere)]) {
        self.shares = share
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
        view.addSubview(pager)
    }
    
    private
    func activateLayouts(){
        NSLayoutConstraint.activate([
            collection.topAnchor.constraint(equalTo: view.topAnchor),
            collection.leftAnchor.constraint(equalTo: view.leftAnchor),
            collection.rightAnchor.constraint(equalTo: view.rightAnchor),
            collection.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            pager.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -115),
            pager.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
}

