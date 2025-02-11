//
//  AttractionTelTableViewCell.swift
//  TravelTaipei
//
//  Created by Steven on 2025/2/11.
//

import UIKit

class AttractionTelTableViewCell: UITableViewCell {

    // MARK: - Property

    // MARK: - UI Content
    lazy var telLabel: UILabel = {
        let label = UILabel()
        label.text = "聯絡電話"
        label.textColor = .mainColor
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
extension AttractionTelTableViewCell {

}

// MARK: - Public
extension AttractionTelTableViewCell {

    func update(with tel: String) {
        self.telLabel.text = tel
        self.telLabel.sizeToFit()
    }
}

// MARK: - Private
extension AttractionTelTableViewCell {

    private func configUI() {
        self.contentView.addSubview(self.telLabel)
        self.telLabel.snp.makeConstraints { make in
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
