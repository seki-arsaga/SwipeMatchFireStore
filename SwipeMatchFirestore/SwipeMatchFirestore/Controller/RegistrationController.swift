//
//  RegistrationController.swift
//  SwipeMatchFirestore
//
//  Created by YusuKe on 2019/03/21.
//  Copyright © 2019年 YusuKe. All rights reserved.
//

import UIKit

class RegistrationController: UIViewController {
    
    //UI Component
    let selectPhotoButon: UIButton = {
       let button = UIButton(type: .system)
        button.setTitle("Select photo", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 32, weight: .heavy)
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
        button.heightAnchor.constraint(equalToConstant: 275).isActive = true
        button.layer.cornerRadius = 16
        return button
    }()
    
    let fullNameTextField: CustomTextField = {
        let tf = CustomTextField(padding: 16)
        tf.placeholder = "Enter full name"
        tf.backgroundColor = .white
        tf.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
        tf.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return tf
    }()
    
    let emailTextField: CustomTextField = {
        let tf = CustomTextField(padding: 16)
        tf.placeholder = "Enter email"
        tf.keyboardType = .emailAddress
        tf.backgroundColor = .white
        tf.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
        return tf
    }()
    
    let passwordTextField: CustomTextField = {
        let tf = CustomTextField(padding: 16)
        tf.placeholder = "Enter password"
        tf.isSecureTextEntry = true
        tf.backgroundColor = .white
        tf.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
        return tf
    }()
    
    let registerButton: UIButton = {
       let button = UIButton(type: .system)
        button.setTitle("Register", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .heavy)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .lightGray
        button.setTitleColor(.gray, for: .disabled)
        button.heightAnchor.constraint(equalToConstant: 44).isActive = true
        button.isEnabled = false
        button.layer.cornerRadius = 22
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupGradientLayer()
        setupLayout()
        setupNotificationObservers()
        setupRegistrationViewModelObserver()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK:- FilePrivate
    @objc fileprivate func handleTextChange(textField: UITextField) {
        if textField == fullNameTextField {
            registerationViewModel.fullName = textField.text
        }else if textField == emailTextField {
            registerationViewModel.email = textField.text
        }else {
            registerationViewModel.password = textField.text
        }
    }
    
    let registerationViewModel = RegistrationViewModel()
    fileprivate func setupRegistrationViewModelObserver() {
        registerationViewModel.isFormValidObservar = { [unowned self] (isFormValid) in
            
            self.registerButton.isEnabled = isFormValid
            if isFormValid {
                self.registerButton.setTitleColor(.white, for: .normal)
                self.registerButton.backgroundColor = UIColor.rgb(red: 210, green: 0, blue: 83)
            } else {
                self.registerButton.backgroundColor = .lightGray
                self.registerButton.setTitleColor(.gray, for: .disabled)
            }
        }
    }
    
    fileprivate func setupNotificationObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc fileprivate func handleKeyboardHide() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.transform = .identity
        }, completion: nil)
    }
    
    @objc func handleKeyboardShow(notification: Notification) {
        guard let value = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardFrame = value.cgRectValue
        
        let bottomSpace = view.frame.height - overallStackView.frame.origin.y - overallStackView.frame.height
        
        let different = keyboardFrame.height - bottomSpace
        self.view.transform = CGAffineTransform(translationX: 0, y: -different - 10)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    lazy var verticalStackView: UIStackView = {
       let sv = UIStackView(arrangedSubviews: [fullNameTextField, emailTextField, passwordTextField, registerButton])
        sv.axis = .vertical
        sv.distribution = .fillEqually
        sv.spacing = 8
        return sv
    }()
    
    lazy var overallStackView = UIStackView(arrangedSubviews: [selectPhotoButon, verticalStackView])
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        if self.traitCollection.verticalSizeClass == .compact {
            overallStackView.axis = .horizontal
        } else {
            overallStackView.axis = .vertical
        }
    }
    
    fileprivate func setupLayout() {
        view.addSubview(overallStackView)
        overallStackView.axis = .horizontal
        selectPhotoButon.widthAnchor.constraint(equalToConstant: 275).isActive = true
        overallStackView.spacing = 8
        overallStackView.anchor(top: nil, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 0, left: 32, bottom: 0, right: 32))
        overallStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    let gradientLayer = CAGradientLayer()

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        gradientLayer.frame = view.bounds
    }
    
    fileprivate func setupGradientLayer() {
        let topColor = UIColor.rgb(red: 253, green: 91, blue: 95)
        let bottomColor = UIColor.rgb(red: 229, green: 0, blue: 114)
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        gradientLayer.locations = [0, 1]
        view.layer.addSublayer(gradientLayer)
        gradientLayer.frame = view.bounds
    }
    
}
