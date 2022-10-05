//
//  MenuViewController.swift
//  InfiniteScrollProducts
//
//  Created by Fabio Silvestri on 04/10/22.
//  Copyright © 2022 fabiosvt, Inc. All rights reserved.
//

import Foundation
import UIKit

class MenuViewController: UIViewController {
    override func loadView() {
        let view = UIView()
        self.view = view
        self.view.backgroundColor = .blue
    }
    
    lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.distribution = .fillEqually
        view.addArrangedSubview(plainViewControllerButton)
        view.addArrangedSubview(subclassedViewButton)
        return view
    }()
    
    lazy var plainViewControllerButton: UIButton = {
       let button = UIButton()
        button.setTitle("Products ViewController", for: .normal)
        button.addTarget(self, action: #selector(didTapProductsButton), for: .touchDown)
        return button
    }()
    
    lazy var subclassedViewButton: UIButton = {
        let button = UIButton()
        button.setTitle("Colors ViewController", for: .normal)
        button.addTarget(self, action: #selector(didTapSubclassedButton), for: .touchDown)
        return button
    }()

    override func viewDidLoad() {
        setupViewCode()
    }

    @objc func didTapProductsButton() {
        self.navigationController?.pushViewController(ViewController(), animated: true)
    }
    
    @objc func didTapSubclassedButton() {
        self.navigationController?.pushViewController(CollectionViewController(), animated: true)
    }

}

// MARK: ViewCode

extension MenuViewController: ViewCode {
    func setupHierarchy() {
        view.addSubview(stackView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            stackView.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    func setupConfiguration() {
        // implement
    }
    
}
