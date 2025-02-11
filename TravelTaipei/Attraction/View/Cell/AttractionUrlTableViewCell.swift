//
//  AttractionUrlTableViewCell.swift
//  TravelTaipei
//
//  Created by Steven on 2025/2/11.
//

import UIKit

class AttractionUrlTableViewCell: UITableViewCell {

    // MARK: - Property

    // MARK: - UI Content
    lazy var urlLabel: UILabel = {
        let label = UILabel()
        label.text = "網址"
        label.textColor = .lmMainColor
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
extension AttractionUrlTableViewCell {

}

// MARK: - Public
extension AttractionUrlTableViewCell {

    func update(with urlString: String) {
        self.urlLabel.text = urlString
        self.urlLabel.sizeToFit()
    }
}

// MARK: - Private
extension AttractionUrlTableViewCell {

    private func configUI() {
        // TODO: Dark mode
        self.contentView.backgroundColor = .white

        self.contentView.addSubview(self.urlLabel)
        self.urlLabel.snp.makeConstraints { make in
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
        shapeLayer.strokeColor = UIColor.lmMainColor.cgColor
        shapeLayer.lineWidth = 2
        self.layer.addSublayer(shapeLayer)
    }
}
