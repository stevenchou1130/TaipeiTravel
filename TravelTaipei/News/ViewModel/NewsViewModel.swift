//
//  NewsViewModel.swift
//  TravelTaipei
//
//  Created by Steven on 2025/2/10.
//

import Foundation

class NewsViewModel {

    private var news: News

    var currentLanguage: Language {
        if let langCode = UserDefaults.standard.string(forKey: Constants.LanguageKey) {
            return Language(rawValue: langCode) ?? .zhTW
        } else {
            return .zhTW
        }
    }
    
    var url: URL? {
        return URL(string: self.news.url)
    }

    init(news: News) {
        self.news = news
    }
}
