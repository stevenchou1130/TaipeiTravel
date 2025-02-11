//
//  AttractionWebViewModel.swift
//  TravelTaipei
//
//  Created by Steven on 2025/2/11.
//

import Foundation

class AttractionWebViewModel {

    private(set) var attraction: Attraction

    var name: String {
        return self.attraction.name
    }

    var url: URL? {
        return URL(string: self.attraction.url)
    }

    init(attraction: Attraction) {
        self.attraction = attraction
    }
}
