//
//  AttractionViewController.swift
//  TravelTaipei
//
//  Created by Steven on 2025/2/10.
//

import UIKit

import SnapKit
import NVActivityIndicatorView

enum AttractionCellType: Int, CaseIterable {
    case images = 0
//    case openTime
//    case address
//    case tel
//    case url
//    case introduction

    var cellClass: UITableViewCell.Type {
        switch self {
        case .images: return AttractionImagesTableViewCell.self
        }
    }

    var reuseCellID: String {
        switch self {
        case .images: return AttractionImagesTableViewCell.reuseCellID
        }
    }

    var cellHeight: CGFloat {
        switch self {
        case .images: return 300
        }
    }
}

class AttractionViewController: UIViewController {

    // MARK: - Property
    let viewModel: AttractionViewModel

    // MARK: - UI Content
    lazy var tableView: UITableView = {
        let tv: UITableView = UITableView(frame: .zero)
        tv.delegate = self
        tv.dataSource = self
        tv.backgroundColor = .clear
        tv.separatorStyle = .none
        for cellType in AttractionCellType.allCases {
            tv.register(cellType.cellClass, forCellReuseIdentifier: cellType.reuseCellID)
        }
        return tv
    }()

    // MARK: - Initialization
    init(viewModel: AttractionViewModel) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("\(Self.self) init(coder:) has not been implemented")
    }

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.configNavBar()
        self.configUI()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
}

// MARK: - Action
extension AttractionViewController {

}

// MARK: - Public
extension AttractionViewController {

}

// MARK: - Private
extension AttractionViewController {

    private func configNavBar() {
        self.navigationItem.title = self.viewModel.currentLanguage.attraction
    }

    private func configUI() {
        self.view.backgroundColor = .white

        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
    }
}

// MARK: - UITableViewDatasource & UITableViewDelegate
extension AttractionViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        return AttractionCellType.allCases[indexPath.row].cellHeight
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return AttractionCellType.allCases.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        switch AttractionCellType.allCases[indexPath.row] {
        case .images:
            let cell: AttractionImagesTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.reset()
            cell.update(with: self.viewModel.images)
            return cell
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
}
