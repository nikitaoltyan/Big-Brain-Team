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
        return label
    }()
    
    let progressTitle: UILabel = {
        let label = UILabel()
            .with(autolayout: false)
            .with(color: Colors.textPrimary)
            .with(alignment: .center)
            .with(numberOfLines: 0)
            .with(fontName: "HelveticaNeue-Medium", size: 20)
        label.text = "Задание 1 из 5"
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
    var currentSelectedIndexPath: IndexPath?
    
    let answers = ["Продам всё", "Куплю ещё акций", "Продам часть", "Подожду"]
    
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
    func checkResultAction() {
        guard isButtonActive else { return }
        nextButton.tap(completion: { _ in
            // TODO:
            // Add checking result.
        })
    }
}






extension QuizController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return answers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: MainConstants.screenWidth-50, height: 48)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collection.dequeueReusableCell(withReuseIdentifier: "QuizCell", for: indexPath) as! QuizCell
        cell.title.text = answers[indexPath.row]
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
            // TODO:
            // Add here some action for selected answer.
            currentSelectedIndexPath = indexPath
        }
    }
    
}





extension QuizController {
    private
    func setSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(closeButton)
        scrollView.addSubview(progressTitle)
        scrollView.addSubview(qustionTitle)
        scrollView.addSubview(chart)
        scrollView.addSubview(collection)
        scrollView.addSubview(nextButton)
        
        closeButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(closeAction)))
    }
    
    private
    func activateLayout() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
            
            closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 25),
            closeButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            
            progressTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            progressTitle.centerYAnchor.constraint(equalTo: closeButton.centerYAnchor),
            
            qustionTitle.topAnchor.constraint(equalTo: progressTitle.bottomAnchor, constant: 35),
            qustionTitle.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24),
            qustionTitle.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24),
            
            chart.topAnchor.constraint(equalTo: qustionTitle.bottomAnchor, constant: 20),
            chart.leftAnchor.constraint(equalTo: view.leftAnchor),
            chart.rightAnchor.constraint(equalTo: view.rightAnchor),
            chart.heightAnchor.constraint(equalToConstant: 285),
            
            collection.topAnchor.constraint(equalTo: chart.bottomAnchor, constant: 16),
            collection.leftAnchor.constraint(equalTo: view.leftAnchor),
            collection.rightAnchor.constraint(equalTo: view.rightAnchor),
            collection.heightAnchor.constraint(equalToConstant: 230),
            
            nextButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            nextButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24),
            nextButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24),
            nextButton.heightAnchor.constraint(equalToConstant: 56),
        ])
    }
}
