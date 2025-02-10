//
//  UIImageView+Ext.swift
//  TravelTaipei
//
//  Created by Steven on 2025/2/11.
//

import UIKit
import Kingfisher

extension UIImageView {

    func loadImage(with url: URL?) {
        self.kf.indicatorType = .activity
        self.kf.setImage(with: url)
    }

    func loadImage(with urlString: String) {
        let url = URL(string: urlString)
        self.loadImage(with: url)
    }
}
