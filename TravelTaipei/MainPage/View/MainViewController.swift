//
//  MainViewController.swift
//  TravelTaipei
//
//  Created by Steven on 2025/2/4.
//

import UIKit
import SnapKit
import MJRefresh
import Combine
import NVActivityIndicatorView

class MainViewController: UIViewController {

    // MARK: - Property
    private var viewModel: MainViewModel = MainViewModel()
    private var cancellables = Set<AnyCancellable>()

    // MARK: - UI Content
    lazy var selectionBtnsView: UIView = {
        let v = UIView(frame: .zero)
        v.backgroundColor = .clear
        return v
    }()

    lazy var attractionsBtn: UIButton = {
        let btn: UIButton = UIButton()
        btn.isSelected = false
        btn.backgroundColor = .lmMainColor
        btn.setTitle(self.viewModel.currentLanguage.attraction, for: .normal)
        btn.setTitleColor(.lmTitleColor, for: .normal)
        btn.setTitleColor(.lmTitleSelectedColor, for: .selected)
        btn.setTitleFont(UIFont.systemFont(ofSize: 16))
        btn.applyRoundedStyle(borderColor: .lmBorderColor)
        btn.addTarget(self, action: #selector(attractionsBtnTapped), for: .touchUpInside)
        return btn
    }()

    lazy var newsBtn: UIButton = {
        let btn: UIButton = UIButton()
        btn.isSelected = true
        btn.backgroundColor = .lmMainColor
        btn.setTitle(self.viewModel.currentLanguage.news, for: .normal)
        btn.setTitleColor(.lmTitleColor, for: .normal)
        btn.setTitleColor(.lmTitleSelectedColor, for: .selected)
        btn.setTitleFont(UIFont.systemFont(ofSize: 16))
        btn.applyRoundedStyle(borderColor: .lmBorderColor)
        btn.addTarget(self, action: #selector(newsBtnTapped), for: .touchUpInside)
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
        // Pull down refresh header
        let header = MJRefreshNormalHeader { [weak self] in
            self?.reload()
        }
        header.loadingView?.color = .clear
        header.lastUpdatedTimeLabel?.isHidden = true
        header.stateLabel?.isHidden = true
        tv.mj_header = header
        return tv
    }()

    lazy var indicator: NVActivityIndicatorView = {
        return NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 40),
                                       type: .lineSpinFadeLoader,
                                       color: .lightGray)
    }()

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.configNavBar()
        self.configUI()
        self.bindViewModel()
        self.reload()
    }
}

// MARK: - UITableViewDatasource & UITableViewDelegate
extension MainViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch self.viewModel.currentContent {
        case .attractions:
            return 150
        case .news:
            return 150
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch self.viewModel.currentContent {
        case .attractions:
            return self.viewModel.attractions.count
        case .news:
            return self.viewModel.news.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch self.viewModel.currentContent {
        case .attractions:
            let cell: MainAttractionsTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            let cellViewModel = MainAttractionCellViewModel(attraction: self.viewModel.attractions[indexPath.row])
            cell.update(with: cellViewModel)
            return cell
        case .news:
            let cell: MainNewsTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            let cellViewModel = MainNewsCellViewModel(news: self.viewModel.news[indexPath.row])
            cell.update(with: cellViewModel)
            return cell
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        switch self.viewModel.currentContent {
        case .attractions:
            let attractionViewModel = AttractionViewModel(attraction: self.viewModel.attractions[indexPath.row])
            let vc = AttractionViewController(viewModel: attractionViewModel)
            self.navigationController?.pushViewController(vc, animated: true)
        case .news:
            let newsViewModel = NewsViewModel(news: self.viewModel.news[indexPath.row])
            let vc = NewsViewController(viewModel: newsViewModel)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        switch self.viewModel.currentContent {
        case .attractions:
            if indexPath.row == self.viewModel.attractions.count - 10 {
                self.viewModel.fetchNextAttractions()
            }
        case .news:
            if indexPath.row == self.viewModel.news.count - 10 {
                self.viewModel.fetchNextNews()
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
            self.reload()
        }
    }

    @objc func attractionsBtnTapped(_ sender: UIButton) {
        if sender.isSelected {
            return
        } else {
            sender.isSelected = true
            self.newsBtn.isSelected = false
            self.viewModel.currentContent = .attractions
            self.reload()
        }
    }

    @objc func langBtnTapped() {
        let alert = UIAlertController(title: self.viewModel.currentLanguage.selectLanguage, message: nil, preferredStyle: .actionSheet)
        for language in Language.allCases {
            let action = UIAlertAction(title: language.name, style: .default) { [weak self] _ in
                self?.changeLanguage(to: language)
            }
            alert.addAction(action)
        }
        alert.addAction(UIAlertAction(title: self.viewModel.currentLanguage.cancel, style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
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
        appearance.backgroundColor = .lmMainColor
        appearance.titleTextAttributes = [.foregroundColor: UIColor.lmTitleColor]
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        self.navigationItem.title = self.viewModel.currentLanguage.title

        self.navigationController?.navigationBar.tintColor = .white
        let langBtnImage = UIImage(systemName: "network")
        let langBtn = UIBarButtonItem(image: langBtnImage, style: .plain, target: self, action: #selector(langBtnTapped))
        self.navigationItem.rightBarButtonItem = langBtn
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
            make.leading.equalTo(self.selectionBtnsView.snp.leading).offset(40)
            make.height.equalTo(30)
            make.width.equalTo(140)
        }

        self.selectionBtnsView.addSubview(self.attractionsBtn)
        self.attractionsBtn.snp.makeConstraints { make in
            make.centerY.equalTo(self.selectionBtnsView)
            make.trailing.equalTo(self.selectionBtnsView.snp.trailing).offset(-40)
            make.height.width.equalTo(self.newsBtn)
        }

        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { make in
            make.top.equalTo(self.selectionBtnsView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }

        self.view.addSubview(self.indicator)
        self.indicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }

    private func bindViewModel() {
        self.viewModel.$attractions
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.tableView.mj_header?.endRefreshing()
                if self?.viewModel.attractions.count != 0 {
                    self?.indicator.stopAnimating()
                }
                self?.tableView.reloadData()
            }
            .store(in: &cancellables)

        self.viewModel.$news
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.tableView.mj_header?.endRefreshing()
                if self?.viewModel.news.count != 0 {
                    self?.indicator.stopAnimating()
                }
                self?.tableView.reloadData()
            }
            .store(in: &cancellables)
    }

    private func reload() {
        self.indicator.startAnimating()
        self.viewModel.reload()
    }

    private func changeLanguage(to language: Language) {
        // Save to user default
        UserDefaults.standard.set(language.rawValue, forKey: Constants.LanguageKey)

        // Update UI
        self.navigationItem.title = language.title
        self.attractionsBtn.setTitle(language.attraction, for: .normal)
        self.newsBtn.setTitle(language.news, for: .normal)

        // Reload data
        self.reload()
    }
}
