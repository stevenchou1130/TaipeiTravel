//
//  AttractionOpenTimeTableViewCell.swift
//  TravelTaipei
//
//  Created by Steven on 2025/2/11.
//

import UIKit

class AttractionOpenTimeTableViewCell: UITableViewCell {

    // MARK: - Property

    // MARK: - UI Content
    lazy var openTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "營業時間"
        label.textColor = .textColor
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.numberOfLines = 0
        return label
    }()

    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.selectionStyle = .none

        self.configUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("\(Self.self) init(coder:) has not been implemented")
    }

    // MARK: - Life Cycle
    override func layoutSubviews() {
        super.layoutSubviews()

        self.addBorder()
    }
}

// MARK: - Action
extension AttractionOpenTimeTableViewCell {

}

// MARK: - Public
extension AttractionOpenTimeTableViewCell {

    func update(with openTime: String) {
        self.openTimeLabel.text = openTime
        self.openTimeLabel.sizeToFit()
    }
}

// MARK: - Private
extension AttractionOpenTimeTableViewCell {

    private func configUI() {
        self.contentView.addSubview(self.openTimeLabel)
        self.openTimeLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(12)
        }
    }

    private func addBorder() {
        self.layer.sublayers?.first(where: { $0.name == "shapeLayer" })?.removeFromSuperlayer()
        let shapeLayer = CAShapeLayer()
        shapeLayer.name = "shapeLayer"
        let path = UIBezierPath(roundedRect: self.bounds.insetBy(dx: 4, dy: 4),
                                cornerRadius: 10)
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor.mainColor.cgColor
        shapeLayer.lineWidth = 2
        self.layer.addSublayer(shapeLayer)
    }
}
