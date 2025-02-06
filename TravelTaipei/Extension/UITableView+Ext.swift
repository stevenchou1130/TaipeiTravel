//
//  UITableView+Ext.swift
//  TravelTaipei
//
//  Created by Steven on 2025/2/6.
//

import UIKit

extension UITableViewCell {

    static var reuseCellID: String {
        return String(describing: self)
    }
}

extension UITableView {

    public func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {

        guard let cell = dequeueReusableCell(withIdentifier: T.reuseCellID, for: indexPath) as? T else {
            fatalError("Unable to dequeue reusable cell - \(T.reuseCellID)")
        }

        return cell
    }
}
