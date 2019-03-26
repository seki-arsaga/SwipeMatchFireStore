//
//  Bindable.swift
//  SwipeMatchFirestore
//
//  Created by YusuKe on 2019/03/27.
//  Copyright © 2019年 YusuKe. All rights reserved.
//

import Foundation

class Bindable<T> {
    
    var value: T? {
        didSet {
            observer?(value)
        }
    }
    
    var observer: ((T?) -> ())?
    
    func bind(observer: @escaping (T?) -> ()) {
        self.observer = observer
    }
    
}
