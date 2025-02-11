//
//  UIViewController+Ext.swift
//  TravelTaipei
//
//  Created by Steven on 2025/2/12.
//


import UIKit

extension UIViewController {
    
    func showInvalidUrlErrorAlert() {
        var currentLanguage: Language {
            if let langCode = UserDefaults.standard.string(forKey: Constants.LanguageKey) {
                return Language(rawValue: langCode) ?? .zhTW
            } else {
                return .zhTW
            }
        }

        let alert = UIAlertController(title: currentLanguage.error, message: currentLanguage.invalidURL, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: currentLanguage.ok, style: .default))
        self.present(alert, animated: true)
    }
}
