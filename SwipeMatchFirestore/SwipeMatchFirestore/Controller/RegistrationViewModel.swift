//
//  RegistrationViewModel.swift
//  SwipeMatchFirestore
//
//  Created by YusuKe on 2019/03/25.
//  Copyright © 2019年 YusuKe. All rights reserved.
//

import UIKit

class RegistrationViewModel {
    
    var fullName: String? { didSet{ checkFormValidity() } }
    var email: String? { didSet { checkFormValidity() } }
    var password: String? { didSet { checkFormValidity() } }
    
    fileprivate func checkFormValidity() {
        let isFormValid = fullName?.isEmpty == false && email?.isEmpty == false && password?.isEmpty == false
        isFormValidObservar?(isFormValid)
    }
    
    //Reactive programing
    var isFormValidObservar: ((Bool) -> ())?
    
}
