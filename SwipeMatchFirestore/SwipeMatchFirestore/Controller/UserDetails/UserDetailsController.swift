//
//  UserDetailsController.swift
//  SwipeMatchFirestore
//
//  Created by YusuKe on 2019/04/14.
//  Copyright © 2019年 YusuKe. All rights reserved.
//

import UIKit
import SDWebImage

class UserDetailsController: UIViewController, UIScrollViewDelegate {
    
    // you should really create a different viewModel object for UserDetail
    var cardViewModel: CardViewModel! {
        didSet {
            infoLabel.attributedText = cardViewModel.attributedString
            
            swipingPhotosController.cardViewModel = cardViewModel
//            guard let firstImageUrl = cardViewModel.imageUrls.first, let url = URL(string: firstImageUrl) else { return }
//            imageView.sd_setImage(with: url, completed: nil)
        }
    }
    
    lazy var scrollView: UIScrollView = {
       let sv = UIScrollView()
        sv.alwaysBounceVertical = true
        sv.contentInsetAdjustmentBehavior = .never
        sv.delegate = self
        return sv
    }()
    
    let swipingPhotosController = SwipingPhotosController()
    
    let infoLabel: UILabel = {
        let label = UILabel()
        label.text = "User name 30\nDoctore\nSome bio text down below"
        label.numberOfLines = 0
        return label
    }()
    
    let dismissButton: UIButton = {
       let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "dismiss").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(hanleTapDismiss), for: .touchUpInside)
        return button
    }()
    
    @objc fileprivate func hanleTapDismiss() {
        self.dismiss(animated: true, completion: nil)
    }
    
    // 3 buttom control buttons
    
    lazy var dislikeButton = self.createButton(image: #imageLiteral(resourceName: "Image-1"), selector: #selector(handleDislike))
    lazy var superLikeButton = self.createButton(image: #imageLiteral(resourceName: "Image-2"), selector: #selector(handleDislike))
    lazy var likeButton = self.createButton(image: #imageLiteral(resourceName: "Image-3"), selector: #selector(handleDislike))
    
    @objc fileprivate func handleDislike() {
        
    }
    
    fileprivate func createButton(image: UIImage, selector: Selector) -> UIButton {
        let button = UIButton(type: .system)
        button.setImage(image.withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: selector, for: .touchUpInside)
        button.imageView?.contentMode = .scaleAspectFill
        return button
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        setupVisualBlurEffectView()
        setupBottomControls()
    }
    
    fileprivate func setupBottomControls() {
        let stackView = UIStackView(arrangedSubviews: [dislikeButton, superLikeButton, likeButton])
        stackView.spacing = -32
        stackView.distribution = .fillEqually
        view.addSubview(stackView)
        stackView.anchor(top: nil, leading: nil, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: nil, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: 300, height: 80))
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    fileprivate func setupVisualBlurEffectView() {
        let blurEffect = UIBlurEffect(style: .regular)
        let visualEffectView = UIVisualEffectView(effect: blurEffect)
        
        view.addSubview(visualEffectView)
        visualEffectView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.topAnchor, trailing: view.trailingAnchor)
    }
    
    fileprivate func setupLayout() {
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.fillSuperview()
        
        let swipingView = swipingPhotosController.view!
        scrollView.addSubview(swipingView)
        
        scrollView.addSubview(infoLabel)
        infoLabel.anchor(top: swipingView.bottomAnchor, leading: scrollView.leadingAnchor, bottom: nil, trailing: scrollView.trailingAnchor, padding: .init(top: 16, left: 16, bottom: 0, right: 16))
        
        scrollView.addSubview(dismissButton)
        dismissButton.anchor(top: swipingView.bottomAnchor, leading: nil, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: -25, left: 0, bottom: 0, right: 24), size: .init(width: 50, height: 50))
    }
    
    fileprivate let extraSwpingHeight: CGFloat = 80
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        let swipingView = swipingPhotosController.view!
        swipingView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.width + extraSwpingHeight)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let changeY = -scrollView.contentOffset.y
        print(changeY)
        var width = view.frame.width + changeY * 2
        width = max(view.frame.width, width)
        let imageView = swipingPhotosController.view!
        imageView.frame = CGRect(x: min(0, -changeY), y: min(0, -changeY), width: width , height: width + extraSwpingHeight)
    }

}
