//
//  MainViewModel.swift
//  TravelTaipei
//
//  Created by Steven on 2025/2/5.
//

class MainViewModel {
    private var attractionsTotal: Int = 999
    private var nextAttractionsPage: Int = 1
    private var attractions: [Attraction] = []
}

// MARK: - Public
extension MainViewModel {

    func fetchAttractions() {
        self.resetAttractionsData()
        self.fetchAttractions(page: self.nextAttractionsPage)
        self.nextAttractionsPage += 1
    }

    func fetchNextAttractions() {
        if self.attractions.count == attractionsTotal {
            return
        }
        self.fetchAttractions(page: self.nextAttractionsPage)
        self.nextAttractionsPage += 1
    }
}

// MARK: - Private
extension MainViewModel {

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
}
