//
//  MainViewModel.swift
//  TravelTaipei
//
//  Created by Steven on 2025/2/5.
//

// TODO:
// 1. API completion
// 2. binding

import Combine

enum MainViewContent {
    case news
    case attractions
}

class MainViewModel {

    var currentContent: MainViewContent = .news

    // Attractions
    private var attractionsTotal: Int = 999
    private var nextAttractionsPage: Int = 1
    @Published private(set) var attractions: [Attraction] = []

    // News
    private var newsTotal: Int = 999
    private var nextNewsPage: Int = 1
    @Published private(set) var news: [News] = []
}

// MARK: - Public
extension MainViewModel {

    // Attractions
    func fetchAttractions() {
        self.resetAttractionsData()
        self.fetchAttractions(page: self.nextAttractionsPage)
        self.nextAttractionsPage += 1
    }

    func fetchNextAttractions() {
        if self.attractions.count == self.attractionsTotal {
            return
        }
        self.fetchAttractions(page: self.nextAttractionsPage)
        self.nextAttractionsPage += 1
    }

    // News
    func fetchNews() {
        self.resetNewsData()
        self.fetchNews(page: self.nextNewsPage)
        self.nextNewsPage += 1
    }

    func fetchNextNews() {
        if self.news.count == self.newsTotal {
            return
        }
        self.fetchNews(page: self.nextNewsPage)
        self.nextNewsPage += 1
    }
}

// MARK: - Private
extension MainViewModel {

    // Attractions
    private func resetAttractionsData() {
        self.nextAttractionsPage = 1
        self.attractions = []
    }

    private func fetchAttractions(page: Int) {
        APIManager.shared.request(apiContent: .attractionsAll(page: "\(page)"), model: AttractionsModel.self) { [weak self] result in

            guard let self = self else {
                print("ERROR: Can not access object")
                return
            }

            switch result {
            case .success(let attractions):
                self.attractionsTotal = attractions.total
                self.attractions.append(contentsOf: attractions.data)
            case .failure(let error):
                print("ERROR: \(error)")
            }
        }
    }

    // News
    private func resetNewsData() {
        self.nextNewsPage = 1
        self.news = []
    }

    private func fetchNews(page: Int) {
        APIManager.shared.request(apiContent: .eventsNews(page: "\(page)"), model: NewsModel.self) { [weak self] result in

            guard let self = self else {
                print("ERROR: Can not access object")
                return
            }

            switch result {
            case .success(let news):
                self.newsTotal = news.total
                self.news.append(contentsOf: news.data)
            case .failure(let error):
                print("ERROR: \(error)")
            }
        }
    }
}
