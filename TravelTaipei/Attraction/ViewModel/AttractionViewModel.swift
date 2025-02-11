//
//  AttractionViewModel.swift
//  TravelTaipei
//
//  Created by Steven on 2025/2/10.
//

import Foundation

class AttractionViewModel {

    private(set) var attraction: Attraction

    var currentLanguage: Language {
        if let langCode = UserDefaults.standard.string(forKey: Constants.LanguageKey) {
            return Language(rawValue: langCode) ?? .zhTW
        } else {
            return .zhTW
        }
    }

    var name: String {
        return self.attraction.name
    }

    var images: [Image] {
        return self.attraction.images
    }

    var openTime: String {
        let title = self.currentLanguage.openTime
        return "\(title): \(self.attraction.openTime)"
    }

    var address: String {
        let title = self.currentLanguage.address
        return "\(title): \(self.attraction.address)"
    }

    var tel: String {
        let title = self.currentLanguage.tel
        return "\(title): \(self.attraction.tel)"
    }

    var intro: String {
        return self.attraction.introduction
    }

    var urlString: String {
        let title = self.currentLanguage.url
        return "\(title): \(self.attraction.url)"
    }

    init(attraction: Attraction) {
        self.attraction = attraction
    }
}
