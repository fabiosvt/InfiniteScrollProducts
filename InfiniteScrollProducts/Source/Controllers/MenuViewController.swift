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
        view.addArrangedSubview(firstViewControllerButton)
        view.addArrangedSubview(secondViewControllerButton)
        view.addArrangedSubview(thirdViewControllerButton)
        view.addArrangedSubview(fourthViewControllerButton)
        view.addArrangedSubview(fifthViewControllerButton)
        return view
    }()
    
    lazy var firstViewControllerButton: UIButton = {
       let button = UIButton()
        button.setTitle("First ViewController", for: .normal)
        button.addTarget(self, action: #selector(didTapFirstViewControllerButton), for: .touchDown)
        return button
    }()
    
    lazy var secondViewControllerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Second ViewController", for: .normal)
        button.addTarget(self, action: #selector(didTapSecondViewControllerButton), for: .touchDown)
        return button
    }()
    
    lazy var thirdViewControllerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Third ViewController", for: .normal)
        button.addTarget(self, action: #selector(didTapThirdViewControllerButton), for: .touchDown)
        return button
    }()

    lazy var fourthViewControllerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Fourth ViewController", for: .normal)
        button.addTarget(self, action: #selector(didTapFourthViewControllerButton), for: .touchDown)
        return button
    }()

    lazy var fifthViewControllerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Fifth ViewController", for: .normal)
        button.addTarget(self, action: #selector(didTapFifthViewControllerButton), for: .touchDown)
        return button
    }()

    override func viewDidLoad() {
        setupViewCode()
    }

    @objc func didTapFirstViewControllerButton() {
        self.navigationController?.pushViewController(FirstViewController(), animated: true)
    }
    
    @objc func didTapSecondViewControllerButton() {
        self.navigationController?.pushViewController(CollectionViewController(), animated: true)
    }
    
    @objc func didTapThirdViewControllerButton() {
        self.navigationController?.pushViewController(ThirdViewController(), animated: true)
    }

    @objc func didTapFourthViewControllerButton() {
        self.navigationController?.pushViewController(FourthViewController(), animated: true)
    }

    @objc func didTapFifthViewControllerButton() {
        self.navigationController?.pushViewController(FifthViewController(), animated: true)
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
