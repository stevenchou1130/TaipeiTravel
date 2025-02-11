//
//  AttractionImagesTableViewCell.swift
//  TravelTaipei
//
//  Created by Steven on 2025/2/10.
//

import UIKit

class AttractionImagesTableViewCell: UITableViewCell {

    // MARK: - Property
    private let imageWidth: CGFloat = UIScreen.main.bounds.width
    private let imageHeight: CGFloat = 300

    // MARK: - UI Content
    lazy var scrollView: UIScrollView = {
        let sv = UIScrollView(frame: .zero)
        sv.backgroundColor = .lightGray
        sv.delegate = self
        sv.isPagingEnabled = true
        sv.bounces = false
        sv.showsHorizontalScrollIndicator = false
        return sv
    }()

    lazy var stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        return sv
    }()

    lazy var pageControl: UIPageControl = {
        let pc = UIPageControl(frame: .zero)
        pc.addTarget(self, action: #selector(pageControlValueChanged), for: .valueChanged)
        pc.numberOfPages = 1
        return pc
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
    }
}

// MARK: - Action
extension AttractionImagesTableViewCell {

    @objc func pageControlValueChanged(_ sender: UIPageControl) {
        let point = CGPoint(x: self.scrollView.bounds.width * CGFloat(sender.currentPage), y: 0)
        self.scrollView.setContentOffset(point, animated: true)
    }
}

// MARK: - Public
extension AttractionImagesTableViewCell {

    func update(with images: [Image]) {
        images.forEach { image in
            let imgView = UIImageView()
            imgView.loadImage(with: image.src)
            imgView.contentMode = .scaleAspectFill
            imgView.clipsToBounds = true
            imgView.translatesAutoresizingMaskIntoConstraints = false
            imgView.widthAnchor.constraint(equalToConstant: self.imageWidth).isActive = true
            self.stackView.addArrangedSubview(imgView)
        }

        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.stackView.widthAnchor.constraint(equalToConstant: CGFloat(images.count) * self.imageWidth),
            self.stackView.heightAnchor.constraint(equalToConstant: self.imageHeight),
        ])

        self.pageControl.numberOfPages = images.count
    }

    func reset() {
        self.stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        self.pageControl.numberOfPages = 0
    }
}

// MARK: - Private
extension AttractionImagesTableViewCell {

    private func configUI() {
        // TODO: Dark mode
        self.contentView.backgroundColor = .white

        self.contentView.addSubview(self.scrollView)
        self.scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        self.scrollView.addSubview(self.stackView)
        self.stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        self.contentView.addSubview(self.pageControl)
        self.pageControl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(10)
            make.height.equalTo(20)
            make.width.equalTo(200)
        }
    }
}

// MARK: - UIScrollViewDelegate
extension AttractionImagesTableViewCell: UIScrollViewDelegate {

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let page = scrollView.contentOffset.x / scrollView.bounds.width
        self.pageControl.currentPage = Int(page)
    }
}
