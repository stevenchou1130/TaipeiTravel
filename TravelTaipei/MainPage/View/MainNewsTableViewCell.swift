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
        label.textColor = .black
        return label
    }()

    lazy var descriptionLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textAlignment = .left
        label.textColor = .black
        label.numberOfLines = 0
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

        self.contentView.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16)
            make.leading.trailing.equalToSuperview().inset(12)
            make.height.equalTo(20)
        }

        self.contentView.addSubview(self.descriptionLabel)
        self.descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(4)
            make.leading.trailing.equalToSuperview().inset(12)
            make.bottom.equalToSuperview().inset(16)
            make.height.equalTo(100)
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
extension MainNewsTableViewCell {

    public func update(with viewModel: MainNewsCellViewModel) {
        self.viewModel = viewModel
        self.titleLabel.text = viewModel.title
        self.descriptionLabel.text = viewModel.description
    }
}
