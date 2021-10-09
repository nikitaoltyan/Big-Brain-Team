//
//  QuizController.swift
//  Big Brain Team
//
//  Created by Nick Oltyan on 09.10.2021.
//

import UIKit

class QuizController: UIViewController {
    
    let scrollView: UIScrollView = {
        let scroll = UIScrollView()
            .with(autolayout: false)
        scroll.contentSize = CGSize(width: MainConstants.screenWidth, height: MainConstants.screenHeight)
        scroll.bounces = true
        scroll.showsVerticalScrollIndicator = true
        return scroll
    }()
    
    let closeButton: UILabel = {
        let label = UILabel()
            .with(autolayout: false)
            .with(color: Colors.blue)
            .with(alignment: .left)
            .with(numberOfLines: 1)
            .with(fontName: "HelveticaNeue", size: 17)
        label.isUserInteractionEnabled = true
        label.text = "Закрыть"
        label.isHidden = true
        return label
    }()
    
    let currentMoney: UILabel = {
        let label = UILabel()
            .with(autolayout: false)
            .with(color: Colors.textPrimary)
            .with(alignment: .center)
            .with(numberOfLines: 1)
            .with(fontName: "HelveticaNeue-Medium", size: 20)
        label.text = "100 000 ₽"
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
    
    let qustionTitle: UILabel = {
        let label = UILabel()
            .with(autolayout: false)
            .with(color: Colors.textPrimary)
            .with(alignment: .left)
            .with(numberOfLines: 0)
            .with(fontName: "HelveticaNeue-Medium", size: 20)
        label.text = "Стоимость акций Apple упала на 10% за неделю. Что будешь делать?"
        return label
    }()
    
    let chart: UIImageView = {
        let image = UIImageView()
            .with(autolayout: false)
        image.image = UIImage(named: "chart")
        return image
    }()

    lazy var collection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
            .with(autolayout: false)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 12
        layout.minimumInteritemSpacing = 12
        
        collection.isPagingEnabled = false
        collection.isScrollEnabled = false
        collection.backgroundColor = .clear
        collection.showsHorizontalScrollIndicator = false
        collection.delegate = self
        collection.dataSource = self
        
        collection.register(QuizCell.self, forCellWithReuseIdentifier: "QuizCell")
        
        return collection
    }()
    
    let nextButton: UIButton = {
        let button = UIButton()
            .with(autolayout: false)
            .with(bgColor: Colors.blue)
            .with(cornerRadius: 24)
        
        button.titleLabel?.font = UIFont(name: "HelveticaNeue", size: 16)
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Посмотреть результат", for: .normal)
        button.alpha = 0.3
        return button
    }()
    
    var isButtonActive = false
    var isAnswersShown = false
    var currentSelectedIndexPath: IndexPath?
    var collectionHeightConstraint: NSLayoutConstraint?
    
    let answers = ["Продам всё", "Куплю ещё акций", "Продам часть", "Подожду"]
    let rightCell = [false, false, false, true]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.primary1
        setSubviews()
        activateLayout()
    }

    
    @objc
    func closeAction() {
        print("closeAction")
        closeButton.tap(completion: { _ in
            self.dismiss(animated: true, completion: nil)
        })
    }
    
    
    @objc
    func openEducation() {
        educationBook.tap(completion: { _ in
            guard let url = URL(string: "https://broker.vtb.ru/learning/azbuka/") else { return }
            UIApplication.shared.open(url)
        })
    }
    
    
    @objc
    func checkResultAction() {
        print("checkResultAction")
        guard isButtonActive else { return }
        Vibration.soft()
        nextButton.tap(completion: { _ in
            guard !self.isAnswersShown else {
//                self.openLoseController()
                self.openWinController()
                return
            }
            
            self.isAnswersShown = true
            self.collection.isUserInteractionEnabled = false
            self.nextButton.setTitle("Следующий вопрос", for: .normal)
            
            if let index = self.rightCell.firstIndex(of: true) {
                if self.currentSelectedIndexPath?.row != index {
                    self.collectionHeightConstraint?.constant = 300
                    self.collection.layoutIfNeeded()
                    self.nextButton.layoutIfNeeded()
                    self.scrollView.contentSize = CGSize(width: MainConstants.screenWidth,
                                                         height: MainConstants.screenHeight + 60)
                }
            }
            self.collection.reloadData()
        })
    }
    
    private
    func openLoseController() {
        let newVC = QuizEndController()
        newVC.modalPresentationStyle = .fullScreen
        self.present(newVC, animated: true, completion: nil)
    }
    
    private
    func openWinController() {
        let newVC = QuizWinController()
        newVC.modalPresentationStyle = .fullScreen
        self.present(newVC, animated: true, completion: nil)
    }
}






extension QuizController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return answers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if !isButtonActive {
            return CGSize(width: MainConstants.screenWidth-50, height: 48)
        } else {
            if currentSelectedIndexPath != indexPath {
                return CGSize(width: MainConstants.screenWidth-50, height: 48)
            } else {
                return CGSize(width: MainConstants.screenWidth-50, height: 118)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collection.dequeueReusableCell(withReuseIdentifier: "QuizCell", for: indexPath) as! QuizCell
        cell.title.text = answers[indexPath.row]
        let isTapped = (indexPath == currentSelectedIndexPath)
        cell.setCell(isCellRight: rightCell[indexPath.row],
                     isTapped: isTapped,
                     isAnswersShown: self.isAnswersShown)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        Vibration.soft()
        if let cell = collection.cellForItem(at: currentSelectedIndexPath ?? indexPath) as? QuizCell {
            cell.unselect()
        }
        
        if let cell = collection.cellForItem(at: indexPath) as? QuizCell {
            cell.select()
            isButtonActive = true
            nextButton.alpha = 1
            currentSelectedIndexPath = indexPath
        }
    }
    
}





extension QuizController {
    private
    func setSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(closeButton)
        scrollView.addSubview(currentMoney)
        scrollView.addSubview(balanceLabel)
        scrollView.addSubview(educationBook)
        scrollView.addSubview(qustionTitle)
        scrollView.addSubview(chart)
        scrollView.addSubview(collection)
        scrollView.addSubview(nextButton)
        
        closeButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(closeAction)))
        nextButton.addTarget(self, action: #selector(checkResultAction), for: .touchUpInside)
        educationBook.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openEducation)))
    }
    
    private
    func activateLayout() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
            
            closeButton.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 55),
            closeButton.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 10),
            
            currentMoney.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 46),
            currentMoney.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            balanceLabel.topAnchor.constraint(equalTo: currentMoney.bottomAnchor, constant: 2),
            balanceLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            educationBook.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -13),
            educationBook.centerYAnchor.constraint(equalTo: closeButton.centerYAnchor),
            
            qustionTitle.topAnchor.constraint(equalTo: balanceLabel.bottomAnchor, constant: 26),
            qustionTitle.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24),
            qustionTitle.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24),
            
            chart.topAnchor.constraint(equalTo: qustionTitle.bottomAnchor, constant: 20),
            chart.leftAnchor.constraint(equalTo: view.leftAnchor),
            chart.rightAnchor.constraint(equalTo: view.rightAnchor),
            chart.heightAnchor.constraint(equalToConstant: 285),
            
            collection.topAnchor.constraint(equalTo: chart.bottomAnchor, constant: 16),
            collection.leftAnchor.constraint(equalTo: view.leftAnchor),
            collection.rightAnchor.constraint(equalTo: view.rightAnchor),
            
            nextButton.topAnchor.constraint(equalTo: collection.bottomAnchor, constant: 30),
            nextButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24),
            nextButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24),
            nextButton.heightAnchor.constraint(equalToConstant: 56),
        ])
        
        collectionHeightConstraint = collection.heightAnchor.constraint(equalToConstant: 230)
        collectionHeightConstraint?.isActive = true
    }
}
