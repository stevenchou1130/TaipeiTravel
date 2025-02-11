//
//  AttractionWebViewController.swift
//  TravelTaipei
//
//  Created by Steven on 2025/2/11.
//

import UIKit
import WebKit
import SnapKit
import NVActivityIndicatorView

class AttractionWebViewController: UIViewController {

    // MARK: - Property
    let viewModel: AttractionWebViewModel

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
    init(viewModel: AttractionWebViewModel) {
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
extension AttractionWebViewController {

    private func load() {
        if let url = self.viewModel.url {
            self.webView.load(URLRequest(url: url))
        } else {
            self.showErrorAlert()
        }
    }

    // TODO: 多國語系
    private func showErrorAlert() {
        let alert = UIAlertController(title: "Error", message: "Invalid URL", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

// MARK: - Public
extension AttractionWebViewController {

}

// MARK: - Private
extension AttractionWebViewController {

    private func configNavBar() {
        self.navigationItem.title = self.viewModel.name
    }

    private func configUI() {
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
extension AttractionWebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        self.indicator.startAnimating()
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.indicator.stopAnimating()
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        self.indicator.stopAnimating()
        self.showErrorAlert()
    }
}
