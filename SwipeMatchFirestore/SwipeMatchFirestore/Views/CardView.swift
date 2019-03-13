//
//  CardView.swift
//  SwipeMatchFirestore
//
//  Created by YusuKe on 2019/03/07.
//  Copyright © 2019年 YusuKe. All rights reserved.
//

import UIKit

class CardView: UIView {

    let imageView = UIImageView(image: #imageLiteral(resourceName: "harden_image"))
    let informationLabel = UILabel()
    
    // Configurations
    let threshold: CGFloat = 80
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 15
        clipsToBounds = true
        
        imageView.contentMode = .scaleAspectFill
        addSubview(imageView)
        imageView.fillSuperview()
        
        addSubview(informationLabel)
        
        informationLabel.numberOfLines = 0
        informationLabel.translatesAutoresizingMaskIntoConstraints = false
        [
            informationLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            informationLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            informationLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            ].forEach{ $0.isActive = true }
        informationLabel.text = "TEST NAME TEST NAME AGE"
        informationLabel.font = UIFont.systemFont(ofSize: 34, weight: .heavy)
        informationLabel.textColor = UIColor.white
//        informationLabel.isLayoutMarginsRelativeArrangement = true
        informationLabel.layoutMargins = .init(top: 0, left: 16, bottom: 16, right: 16)
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        addGestureRecognizer(panGesture)
    }
    
    @objc fileprivate func handlePan(gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .changed:
            handleChanged(gesture)
        case .ended:
            handleEnded(gesture)
        default:
            ()
        }
    }
    
    fileprivate func handleChanged(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: nil)
        let degreea: CGFloat = translation.x / 20
        let angle = degreea * .pi / 100
        
        let rotationalTransformation = CGAffineTransform(rotationAngle: angle)
        self.transform = rotationalTransformation.translatedBy(x: translation.x, y: translation.y)
    }
    
    fileprivate func handleEnded(_ gesture: UIPanGestureRecognizer) {
        let translationDirection: CGFloat = gesture.translation(in: nil).x > 0 ? 1 : -1
        let shouldDismissCard = abs(gesture.translation(in: nil).x) > threshold
        
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.1, options: .curveEaseOut, animations: {
            if shouldDismissCard {
                self.frame = CGRect(x: 600 * translationDirection, y: 0, width: self.frame.width, height: self.frame.height)
                
            }else {
                self.transform = .identity
            }
        }) { (_) in
            self.transform = .identity
            if shouldDismissCard {
                self.removeFromSuperview()
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
