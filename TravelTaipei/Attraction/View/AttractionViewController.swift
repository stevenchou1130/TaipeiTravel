//
//  AttractionViewController.swift
//  TravelTaipei
//
//  Created by Steven on 2025/2/10.
//

import UIKit

import SnapKit

enum AttractionCellType: Int, CaseIterable {
    case images
    case openTime
    case address
    case tel
    case url
    case introduction

    var cellClass: UITableViewCell.Type {
        switch self {
        case .images: return AttractionImagesTableViewCell.self
        case .openTime: return AttractionOpenTimeTableViewCell.self
        case .address: return AttractionAddressTableViewCell.self
        case .tel: return AttractionTelTableViewCell.self
        case .url: return AttractionUrlTableViewCell.self
        case .introduction: return AttractionIntroTableViewCell.self
        }
    }

    var reuseCellID: String {
        switch self {
        case .images: return AttractionImagesTableViewCell.reuseCellID
        case .openTime: return AttractionOpenTimeTableViewCell.reuseCellID
        case .address: return AttractionAddressTableViewCell.reuseCellID
        case .tel: return AttractionTelTableViewCell.reuseCellID
        case .url: return AttractionUrlTableViewCell.reuseCellID
        case .introduction: return AttractionIntroTableViewCell.reuseCellID
        }
    }

    var cellHeight: CGFloat {
        switch self {
        case .images: return 300
        case .openTime: return UITableView.automaticDimension
        case .address: return UITableView.automaticDimension
        case .tel: return UITableView.automaticDimension
        case .url: return UITableView.automaticDimension
        case .introduction: return UITableView.automaticDimension
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

        let indexPath = IndexPath(row: 0, section: 0)
        self.tableView.reloadRows(at: [indexPath], with: .automatic)
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
        self.navigationItem.title = self.viewModel.name
    }

    private func configUI() {
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
        case .openTime:
            let cell: AttractionOpenTimeTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.update(with: self.viewModel.openTime)
            return cell
        case .address:
            let cell: AttractionAddressTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.update(with: self.viewModel.address)
            return cell
        case .tel:
            let cell: AttractionTelTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.update(with: self.viewModel.tel)
            return cell
        case .url:
            let cell: AttractionUrlTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.update(with: self.viewModel.urlString)
            return cell
        case .introduction:
            let cell: AttractionIntroTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.update(with: self.viewModel.intro)
            return cell
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let cellType = AttractionCellType.allCases[indexPath.row]

        if cellType == .url {
            let viewModel = AttractionWebViewModel(attraction: self.viewModel.attraction)
            let vc = AttractionWebViewController(viewModel: viewModel)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
