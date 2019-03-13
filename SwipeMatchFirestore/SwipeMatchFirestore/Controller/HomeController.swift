//
//  ViewController.swift
//  SwipeMatchFirestore
//
//  Created by YusuKe on 2019/03/05.
//  Copyright © 2019年 YusuKe. All rights reserved.
//

import UIKit

class HomeController: UIViewController {

    let topStackView = TopNavigationStackViews()
    let cardDeckView = UIView()
    let bottomsStackView = HomeBottomControlsStackView()
    
//    let users = [
//        User(name: "Kelly", age: 23, profession: "music DJ", imageName: "harden_image"),
//        User(name: "Jane", age: 18, profession: "Teacher", imageName: "curry_image")
//    ]
    
    let cardViewModels = [
        User(name: "Kelly", age: 23, profession: "music DJ", imageName: "harden_image").toCardViewModel(),
        User(name: "Jane", age: 18, profession: "Teacher", imageName: "curry_image").toCardViewModel()
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupLayout()
        setupDummyCards()
    }

    fileprivate func setupDummyCards() {
        cardViewModels.forEach { (cardVM) in
            let cardView = CardView(frame: .zero)
            cardView.imageView.image = UIImage(named: cardVM.imageName)
            cardView.informationLabel.attributedText = cardVM.attributedString
            cardView.informationLabel.textAlignment = cardVM.textAlignment
            cardDeckView.addSubview(cardView)
            cardView.fillSuperview()
        }
        
//        users.forEach { (user) in
//            let cardView = CardView(frame: .zero)
//            cardView.imageView.image = UIImage(named: user.imageName)
////            cardView.informationLabel.text = "\(user.name) \(user.age) \n \(user.profession)"
////
////            let attributedText = NSMutableAttributedString(string: user.name, attributes: [.font: UIFont.systemFont(ofSize: 32, weight: .heavy)])
////            attributedText.append(NSAttributedString(string: " \(user.age)", attributes: [.font: UIFont.systemFont(ofSize: 24, weight: .regular)]))
////            attributedText.append(NSAttributedString(string: " \n\(user.profession)", attributes: [.font: UIFont.systemFont(ofSize: 20, weight: .regular)]))
//
//            cardView.informationLabel.attributedText = attributedText
//
//            cardDeckView.addSubview(cardView)
//            cardView.fillSuperview()
//        }
    }
    
    //MARK:- Fileprivate
    
    fileprivate func setupLayout() {
        let overallStackView = UIStackView(arrangedSubviews: [topStackView, cardDeckView, bottomsStackView])
        overallStackView.axis = .vertical
        
        view.addSubview(overallStackView)
        overallStackView.translatesAutoresizingMaskIntoConstraints = false
        [
            overallStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            overallStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            overallStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            overallStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            ].forEach{ $0.isActive = true }
        overallStackView.isLayoutMarginsRelativeArrangement = true
        overallStackView.layoutMargins = .init(top: 0, left: 8, bottom: 0, right: 8)
        
        overallStackView.bringSubviewToFront(cardDeckView)
    }

}

