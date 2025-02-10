//
//  MainAttractionsTableViewCell.swift
//  TravelTaipei
//
//  Created by Steven on 2025/2/6.
//

import UIKit
import Kingfisher

class MainAttractionsTableViewCell: UITableViewCell {

    var viewModel: MainAttractionCellViewModel?

    // MARK: - UI Content
    lazy var imgView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 10
        iv.backgroundColor = .lightGray
        return iv
    }()

    lazy var nameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textAlignment = .left
        label.textColor = .black
        return label
    }()

    lazy var introductionLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textAlignment = .left
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()

    lazy var arrowImgView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "chevron.right")
        iv.tintColor = .lmMainColor
        return iv
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
extension MainAttractionsTableViewCell {

    public func update(with viewModel: MainAttractionCellViewModel) {
        self.viewModel = viewModel
        self.imgView.kf.setImage(with: viewModel.imgURL)
        self.nameLabel.text = viewModel.name
        self.introductionLabel.text = viewModel.introduction
    }
}

// MARK: - Private
extension MainAttractionsTableViewCell {

    private func configUI() {
        self.contentView.addSubview(self.imgView)
        self.imgView.snp.makeConstraints { make in
            make.size.equalTo(50)
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
        }

        self.contentView.addSubview(self.nameLabel)
        self.nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16)
            make.leading.equalTo(self.imgView.snp.trailing).offset(8)
            make.height.equalTo(20)
        }

        self.contentView.addSubview(self.introductionLabel)
        self.introductionLabel.snp.makeConstraints { make in
            make.top.equalTo(self.nameLabel.snp.bottom).offset(8)
            make.leading.trailing.equalTo(self.nameLabel)
            make.bottom.equalToSuperview().inset(16)
            make.height.equalTo(100)
        }

        self.contentView.addSubview(self.arrowImgView)
        self.arrowImgView.snp.makeConstraints { make in
            make.leading.equalTo(self.nameLabel.snp.trailing).offset(4)
            make.trailing.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
            make.size.equalTo(20)
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
        shapeLayer.strokeColor = UIColor.lmMainColor.cgColor
        shapeLayer.lineWidth = 2
        self.layer.addSublayer(shapeLayer)
    }
}
