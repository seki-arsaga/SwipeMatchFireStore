//
//  CardViewModel.swift
//  SwipeMatchFirestore
//
//  Created by YusuKe on 2019/03/12.
//  Copyright © 2019年 YusuKe. All rights reserved.
//

import UIKit

protocol ProducesCardViewModel {
    func toCardViewModel() -> CardViewModel
}

struct CardViewModel {
    
    let imageName: String
    let attributedString: NSAttributedString
    let textAlignment: NSTextAlignment
}

