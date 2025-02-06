//
//  UIButton+Ext.swift
//  TravelTaipei
//
//  Created by Steven on 2025/2/6.
//

import UIKit

extension UIButton {

    func setTitleFont(_ font: UIFont) {
        self.titleLabel?.font = font
    }

    func applyRoundedStyle(cornerRadius: CGFloat = 10, borderWidth: CGFloat = 1, borderColor: UIColor = .black, shadowColor: UIColor = .gray, shadowOpacity: Float = 0.3, shadowRadius: CGFloat = 4, shadowOffset: CGSize = CGSize(width: 1, height: 1)) {

        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor

        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowRadius = shadowRadius
        self.layer.shadowOffset = shadowOffset
        self.layer.masksToBounds = false
    }
}
