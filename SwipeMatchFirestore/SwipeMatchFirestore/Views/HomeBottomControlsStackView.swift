//
//  HomeBottomControlsStackView.swift
//  SwipeMatchFirestore
//
//  Created by YusuKe on 2019/03/07.
//  Copyright © 2019年 YusuKe. All rights reserved.
//

import UIKit

class HomeBottomControlsStackView: UIStackView {
    
    static func createButton(image: UIImage) -> UIButton {
        let button = UIButton(type: .system)
        button.setImage(image.withRenderingMode(.alwaysOriginal), for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        return button
    }
    
    let refreshButton = createButton(image: #imageLiteral(resourceName: "Image"))
    let dislikeButton = createButton(image: #imageLiteral(resourceName: "Image-1"))
    let superLikeButton = createButton(image: #imageLiteral(resourceName: "Image-2"))
    let likeButton = createButton(image: #imageLiteral(resourceName: "Image-3"))
    let specialButton = createButton(image: #imageLiteral(resourceName: "Image-4"))

    override init(frame: CGRect) {
        super.init(frame: frame)
        distribution = .fillEqually
        heightAnchor.constraint(equalToConstant: 100).isActive = true

        [refreshButton, dislikeButton, superLikeButton, likeButton, specialButton].forEach { (button) in
            self.addArrangedSubview(button)
        }
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
