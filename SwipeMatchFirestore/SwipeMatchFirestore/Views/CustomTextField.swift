//
//  CustomTextField.swift
//  SwipeMatchFirestore
//
//  Created by YusuKe on 2019/03/21.
//  Copyright © 2019年 YusuKe. All rights reserved.
//

import UIKit

class CustomTextField: UITextField {

    let padding: CGFloat
    
    init(padding: CGFloat) {
        self.padding = padding
        super.init(frame: .zero)
        
        layer.cornerRadius = 24
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: padding, dy: 0)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: padding, dy: 0)
    }
    
    override var intrinsicContentSize: CGSize {
        return .init(width: 0, height: 50)
    }
}