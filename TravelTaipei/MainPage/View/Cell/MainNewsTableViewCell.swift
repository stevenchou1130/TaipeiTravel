//
//  MainNewsTableViewCell.swift
//  TravelTaipei
//
//  Created by Steven on 2025/2/6.
//

import UIKit

class MainNewsTableViewCell: UITableViewCell {

    var viewModel: MainNewsCellViewModel?

    // MARK: - UI Content
    lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textAlignment = .left
        label.textColor = .textColor
        return label
    }()

    lazy var descriptionLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textAlignment = .left
        label.textColor = .textColor
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

// MARK: - Public
extension MainNewsTableViewCell {

    public func update(with viewModel: MainNewsCellViewModel) {
        self.viewModel = viewModel
        self.titleLabel.text = viewModel.title
        self.descriptionLabel.text = viewModel.description
    }
}


// MARK: - Private
extension MainNewsTableViewCell {

    private func configUI() {
        self.contentView.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(20)
        }

        self.contentView.addSubview(self.descriptionLabel)
        self.descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(4)
            make.leading.trailing.equalTo(self.titleLabel)
            make.bottom.equalToSuperview().inset(16)
            make.height.equalTo(100)
        }
    }

    private func addBorder() {
        self.layer.sublayers?.first(where: { $0.name == "shapeLayer" })?.removeFromSuperlayer()
        let shapeLayer = CAShapeLayer()
        shapeLayer.name = "shapeLayer"
        let path = UIBezierPath(roundedRect: self.bounds.insetBy(dx: 10, dy: 10),
                                cornerRadius: 10)
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor.mainColor.cgColor
        shapeLayer.lineWidth = 2
        self.layer.addSublayer(shapeLayer)
    }
}
