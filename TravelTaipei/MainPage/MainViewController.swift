//
//  MainViewController.swift
//  TravelTaipei
//
//  Created by Steven on 2025/2/4.
//

import UIKit

class MainViewController: UIViewController {

    // MARK: - Property
    private var viewModel: MainViewModel = MainViewModel()

    // MARK: - UI Content

    // MARK: - Initialization

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .lightGray

        self.viewModel.fetchAttractions()
    }
}

// MARK: - Action
extension MainViewController {

}

// MARK: - Public
extension MainViewController {

}

// MARK: - Private
extension MainViewController {

}
