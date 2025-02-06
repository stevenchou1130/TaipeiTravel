//
//  MainViewController.swift
//  TravelTaipei
//
//  Created by Steven on 2025/2/4.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {

    // MARK: - Property
    private var viewModel: MainViewModel = MainViewModel()

    // MARK: - UI Content
    lazy var selectionBtnsView: UIView = {
        let v = UIView(frame: .zero)
        v.backgroundColor = .clear
        return v
    }()

    lazy var newsBtn: UIButton = {
        let btn: UIButton = UIButton()
        btn.isSelected = true
        btn.backgroundColor = .mainColor
        btn.setTitle("最新消息", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.setTitleColor(.black, for: .selected)
        btn.setTitleFont(UIFont.systemFont(ofSize: 16))
        btn.applyRoundedStyle(borderColor: .white)
        btn.addTarget(self, action: #selector(newsBtnTapped), for: .touchUpInside)
        return btn
    }()

    lazy var attractionsBtn: UIButton = {
        let btn: UIButton = UIButton()
        btn.isSelected = false
        btn.backgroundColor = .mainColor
        btn.setTitle("旅遊景點", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.setTitleColor(.black, for: .selected)
        btn.setTitleFont(UIFont.systemFont(ofSize: 16))
        btn.applyRoundedStyle(borderColor: .white)
        btn.addTarget(self, action: #selector(attractionsBtnTapped), for: .touchUpInside)
        return btn
    }()

    lazy var tableView: UITableView = {
        let tv: UITableView = UITableView(frame: self.view.frame)
        tv.delegate = self
        tv.dataSource = self
        tv.backgroundColor = .clear
        tv.separatorStyle = .none
        tv.register(MainNewsTableViewCell.self, forCellReuseIdentifier: MainNewsTableViewCell.reuseCellID)
        tv.register(MainAttractionsTableViewCell.self, forCellReuseIdentifier: MainAttractionsTableViewCell.reuseCellID)
        return tv
    }()

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.configNavBar()
        self.configUI()

        self.fetchNews()
    }
}

// MARK: - UITableViewDatasource & UITableViewDelegate
extension MainViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        return 100
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        switch self.viewModel.currentContent {
        case .news:
            return self.viewModel.news.count
        case .attractions:
            return self.viewModel.attractions.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        switch self.viewModel.currentContent {
        case .news:
            let cell: MainNewsTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            let data = self.viewModel.news[indexPath.row]
            cell.update(with: data)
            return cell
        case .attractions:
            let cell: MainAttractionsTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            let data = self.viewModel.attractions[indexPath.row]
            cell.update(with: data)
            return cell
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO: Push to detail page
        switch self.viewModel.currentContent {
        case .news:
            print("=== didSelectRowAt news: \(indexPath)")
        case .attractions:
            print("=== didSelectRowAt attractions: \(indexPath)")
        }
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // TODO: Load more
        switch self.viewModel.currentContent {
        case .news:
            if indexPath.row == self.viewModel.news.count - 10 {
                print("=== Load more news")
            }
        case .attractions:
            if indexPath.row == self.viewModel.attractions.count - 10 {
                print("=== Load more attractions")
            }
        }
    }
}

// MARK: - Action
extension MainViewController {

    @objc func newsBtnTapped(_ sender: UIButton) {
        if sender.isSelected {
            return
        } else {
            sender.isSelected = true
            self.attractionsBtn.isSelected = false
            self.viewModel.currentContent = .news
            self.fetchNews()
        }
    }

    @objc func attractionsBtnTapped(_ sender: UIButton) {
        if sender.isSelected {
            return
        } else {
            sender.isSelected = true
            self.newsBtn.isSelected = false
            self.viewModel.currentContent = .attractions
            self.fetchAttractions()
        }
    }

    func fetchNews() {
        self.viewModel.fetchNews { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }

    func fetchAttractions() {
        self.viewModel.fetchAttractions { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
}

// MARK: - Public
extension MainViewController {

}

// MARK: - Private
extension MainViewController {

    private func configNavBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .mainColor
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        self.navigationItem.title = "悠遊台北"
    }

    private func configUI() {

        self.view.backgroundColor = .white

        self.view.addSubview(self.selectionBtnsView)
        self.selectionBtnsView.snp.makeConstraints { make in
            make.leading.equalTo(self.view.snp.leading)
            make.trailing.equalTo(self.view.snp.trailing)
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.height.equalTo(40)
        }

        self.selectionBtnsView.addSubview(self.newsBtn)
        self.newsBtn.snp.makeConstraints { make in
            make.centerY.equalTo(self.selectionBtnsView)
            make.leading.equalTo(self.selectionBtnsView.snp.leading).offset(10)
            make.height.equalTo(30)
            make.width.equalTo(80)
        }

        self.selectionBtnsView.addSubview(self.attractionsBtn)
        self.attractionsBtn.snp.makeConstraints { make in
            make.centerY.equalTo(self.selectionBtnsView)
            make.leading.equalTo(self.newsBtn.snp.trailing).offset(10)
            make.height.width.equalTo(self.newsBtn)
        }

        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { make in
            make.top.equalTo(self.selectionBtnsView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}
