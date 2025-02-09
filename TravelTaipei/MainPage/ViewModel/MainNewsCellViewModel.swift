//
//  MainNewsCellViewModel.swift
//  TravelTaipei
//
//  Created by Steven on 2025/2/10.
//

class MainNewsCellViewModel {

    private var news: News

    var title: String {
        return self.news.title
    }

    var description: String {
        return self.news.description.trimmingCharacters(in: .newlines)
    }

    init(news: News) {
        self.news = news
    }
}
