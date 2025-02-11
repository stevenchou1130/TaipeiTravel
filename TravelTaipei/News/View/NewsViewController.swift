//
//  NewsViewController.swift
//  TravelTaipei
//
//  Created by Steven on 2025/2/10.
//

import UIKit
import WebKit
import SnapKit
import NVActivityIndicatorView

class NewsViewController: UIViewController {

    // MARK: - Property
    let viewModel: NewsViewModel

    // MARK: - UI Content
    lazy var webView: WKWebView = {
        let wv = WKWebView()
        wv.navigationDelegate = self
        return wv
    }()

    lazy var indicator: NVActivityIndicatorView = {
        return NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 40),
                                       type: .lineSpinFadeLoader,
                                       color: .lightGray)
    }()

    // MARK: - Initialization
    init(viewModel: NewsViewModel) {
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
        self.load()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
}

// MARK: - Action
extension NewsViewController {
    
    private func load() {
        if let url = self.viewModel.url {
            self.webView.load(URLRequest(url: url))
        } else {
            self.showInvalidUrlErrorAlert()
        }
    }
}

// MARK: - Public
extension NewsViewController {

}

// MARK: - Private
extension NewsViewController {

    private func configNavBar() {
        self.navigationItem.title = self.viewModel.currentLanguage.news
    }

    private func configUI() {
        self.view.backgroundColor = .systemBackground
        
        self.view.addSubview(self.webView)
        self.webView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        self.view.addSubview(self.indicator)
        self.indicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}

// MARK: - WKNavigationDelegate
extension NewsViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        self.indicator.startAnimating()
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.indicator.stopAnimating()
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        self.indicator.stopAnimating()
        self.showInvalidUrlErrorAlert()
    }
}
