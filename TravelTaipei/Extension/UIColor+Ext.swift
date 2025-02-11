//
//  UIColor+Ext.swift
//  TravelTaipei
//
//  Created by Steven on 2025/2/6.
//

import UIKit

extension UIColor {

    static var mainColor: UIColor = UIColor(red: 133.0/255.0,
                                              green: 194.0/255.0,
                                              blue: 255.0/255.0,
                                              alpha: 1)

    // Navi
    static var navBarTintColor: UIColor {
        if UITraitCollection.current.userInterfaceStyle == .light {
            return .white
        } else {
            return .black
        }
    }

    // Category in main page
    static var categoryBtnTitleColor: UIColor {
        if UITraitCollection.current.userInterfaceStyle == .light {
            return .white
        } else {
            return .black
        }
    }

    static var categoryBtnSelectedTitleColor: UIColor {
        if UITraitCollection.current.userInterfaceStyle == .light {
            return .black
        } else {
            return .white
        }
    }

    static var categoryBtnBorderColor: UIColor = .white

    // Normal Text
    static var textColor: UIColor {
        if UITraitCollection.current.userInterfaceStyle == .light {
            return .black
        } else {
            return .white
        }
    }
}
