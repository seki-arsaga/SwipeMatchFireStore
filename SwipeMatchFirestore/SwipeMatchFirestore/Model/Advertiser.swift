//
//  Advertiser.swift
//  SwipeMatchFirestore
//
//  Created by YusuKe on 2019/03/16.
//  Copyright © 2019年 YusuKe. All rights reserved.
//

import UIKit

struct Advertiser: ProducesCardViewModel {
    let title: String
    let brandName: String
    let posterPhotoName: String
    
    func toCardViewModel() -> CardViewModel {
        let attributedString = NSMutableAttributedString(string: title, attributes: [.font: UIFont.systemFont(ofSize: 32, weight: .heavy)])
        
        attributedString.append(NSAttributedString(string: "\n", attributes: [.font: UIFont.systemFont(ofSize: 24, weight: .bold)]))
        
        return CardViewModel(imageName: posterPhotoName, attributedString: attributedString, textAlignment: .center)
    }
}
