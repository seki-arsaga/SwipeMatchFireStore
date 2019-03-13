//
//  HomeBottomControlsStackView.swift
//  SwipeMatchFirestore
//
//  Created by YusuKe on 2019/03/07.
//  Copyright © 2019年 YusuKe. All rights reserved.
//

import UIKit

class HomeBottomControlsStackView: UIStackView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        distribution = .fillEqually
        heightAnchor.constraint(equalToConstant: 100).isActive = true

        let subViews = [#imageLiteral(resourceName: "Image"), #imageLiteral(resourceName: "Image-1"), #imageLiteral(resourceName: "Image-2"), #imageLiteral(resourceName: "Image-3"), #imageLiteral(resourceName: "Image-4")].map { (img) -> UIView in
            let button = UIButton(type: .system)
            button.setImage(img.withRenderingMode(.alwaysOriginal), for: .normal)
            return button
        }
        
        subViews.forEach { (v) in
            addArrangedSubview(v)
        }
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
