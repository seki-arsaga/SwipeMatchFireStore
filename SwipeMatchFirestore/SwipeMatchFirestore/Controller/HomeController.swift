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
    
    
    let cardViewModels: [CardViewModel] = {
        let producers = [
            User(name: "Kelly", age: 23, profession: "music DJ", imageNames: ["harden_image-1", "harden_image-2", "harden_image-3"]),
            User(name: "Jane", age: 18, profession: "Teacher", imageNames: ["curry_image-1", "curry_image-2", "curry_image-3"]),
            Advertiser(title: "Side Out Menu", brandName: "Lets Build That App", posterPhotoName: "nab-playoffs"),
            User(name: "Jane", age: 18, profession: "Teacher", imageNames: ["curry_image-1", "curry_image-2", "curry_image-3"]),
        ] as [ProducesCardViewModel]
       let viewModels = producers.map({return $0.toCardViewModel()})
        return viewModels
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topStackView.settingsButton.addTarget(self, action: #selector(handleSettings), for: .touchUpInside)
        
        view.backgroundColor = .white
        setupLayout()
        setupDummyCards()
    }
    
    @objc func handleSettings() {
        print("Show register page")
        
        let vc = RegistrationController()
        present(vc, animated: true, completion: nil)
    }
    
    fileprivate func setupDummyCards() {
        cardViewModels.forEach { (cardVM) in
            let cardView = CardView(frame: .zero)
            cardView.cardViewModel = cardVM
            cardDeckView.addSubview(cardView)
            cardView.fillSuperview()
        }
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

