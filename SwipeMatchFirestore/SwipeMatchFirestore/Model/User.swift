//
//  User.swift
//  SwipeMatchFirestore
//
//  Created by YusuKe on 2019/03/10.
//  Copyright © 2019年 YusuKe. All rights reserved.
//

import UIKit

struct User {
    
    let name: String
    let age: Int
    let profession: String
    let imageName: String
    
    func toCardViewModel() -> CardViewModel {
        let attributedText = NSMutableAttributedString(string: name, attributes: [.font: UIFont.systemFont(ofSize: 32, weight: .heavy)])
        attributedText.append(NSAttributedString(string: " \(age)", attributes: [.font: UIFont.systemFont(ofSize: 24, weight: .regular)]))
        attributedText.append(NSAttributedString(string: " \n\(profession)", attributes: [.font: UIFont.systemFont(ofSize: 20, weight: .regular)]))
        
        return CardViewModel(imageName: imageName, attributedString: attributedText, textAlignment: .left)
    }
    
}

