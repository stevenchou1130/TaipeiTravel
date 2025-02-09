//
//  MainAttractionsTableViewCell.swift
//  TravelTaipei
//
//  Created by Steven on 2025/2/6.
//

import UIKit

class MainAttractionsTableViewCell: UITableViewCell {

    // MARK: - UI Content
    lazy var nameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .left
        label.textColor = .black
        return label
    }()

    lazy var introductionLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .left
        label.textColor = .black
        return label
    }()

    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.selectionStyle = .none

        self.contentView.layer.cornerRadius = 10
        self.contentView.layer.borderWidth = 3
        self.contentView.layer.borderColor = UIColor.lmMainColor.cgColor
        self.contentView.layer.masksToBounds = true

        self.contentView.addSubview(self.nameLabel)
        self.nameLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview().inset(8)
            make.height.equalTo(20)
        }

        self.contentView.addSubview(self.introductionLabel)
        self.introductionLabel.snp.makeConstraints { make in
            make.top.equalTo(self.nameLabel.snp.bottom).offset(8)
            make.leading.trailing.bottom.equalToSuperview().inset(8)
            make.height.equalTo(40)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("\(Self.self) init(coder:) has not been implemented")
    }

    // MARK: - Life Cycle
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}

// MARK: - Public
extension MainAttractionsTableViewCell {

    public func update(with data: Attraction) {
        self.nameLabel.text = data.name
        self.introductionLabel.text = data.introduction
    }
}
