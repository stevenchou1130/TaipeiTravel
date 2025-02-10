//
//  MainAttractionCellViewModel.swift
//  TravelTaipei
//
//  Created by Steven on 2025/2/10.
//

import Foundation

class MainAttractionCellViewModel {

    private var attraction: Attraction

    var name: String {
        return self.attraction.name
    }

    var introduction: String {
        return self.attraction.introduction
    }

    var imgURL: URL? {
        if let urlString = self.attraction.images.first?.src {
            return URL(string: urlString)
        } else {
            return nil
        }
    }

    init(attraction: Attraction) {
        self.attraction = attraction
    }
}
