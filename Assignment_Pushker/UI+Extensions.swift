//
//  UI+Extensions.swift
//  Assignment_Pushker
//
//  Created by Pushker Pandey on 12/03/25.
//

import UIKit

extension UIButton {
    
    func applyStyledAppearance() {
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = false
      
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 4)
        self.layer.shadowOpacity = 0.3
        self.layer.shadowRadius = 5

        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.systemBlue.cgColor, UIColor.systemTeal.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        gradientLayer.frame = self.bounds
        gradientLayer.cornerRadius = 10
        self.layer.insertSublayer(gradientLayer, at: 0)
        
        self.addTarget(self, action: #selector(animateButtonPress), for: .touchDown)
        
        self.addTarget(self, action: #selector(animateButtonRelease), for: [.touchUpInside, .touchDragExit])
    }
    
    @objc private func animateButtonPress() {
        UIView.animate(withDuration: 0.1, animations: {
            self.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        })
    }
    
    @objc private func animateButtonRelease() {
        UIView.animate(withDuration: 0.1, animations: {
            self.transform = .identity
        })
    }
}

extension UITextField {
    func setPlaceholder(_ text: String, color: UIColor = .white) {
        self.attributedPlaceholder = NSAttributedString(
            string: text,
            attributes: [NSAttributedString.Key.foregroundColor: color]
        )
    }
}
