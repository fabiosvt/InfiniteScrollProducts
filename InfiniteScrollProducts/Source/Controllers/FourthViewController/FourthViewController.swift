//
//  FourthViewController.swift
//  InfiniteScrollProducts
//
//  Created by Fabio Silvestri on 10/10/22.
//  Copyright © 2022 fabiosvt, Inc. All rights reserved.
//

import UIKit

class FourthViewController: UIViewController, UISearchResultsUpdating {

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        let w = view.frame.width
        layout.estimatedItemSize = CGSize(width: w, height: 150)
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        view.register(CategoryCell.self, forCellWithReuseIdentifier: firstCellId)
        return view
    }()

    func updateSearchResults(for searchController: UISearchController) {
        print("SeachController tapped.")
    }

    let firstCellId = "cellfirstCellIdId"

    var appCategories: [AppCategory]?




    override func viewDidLoad() {
        super.viewDidLoad()
        appCategories = AppCategory.sampleAppCategories()
        collectionView.backgroundColor = UIColor.clear
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.allowsSelection = true
        collectionView.contentInsetAdjustmentBehavior = .never

        
        navigationItem.title = NSLocalizedString("Original", comment: "Original")
        navigationController?.navigationBar.prefersLargeTitles = true

        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        navigationItem.hidesSearchBarWhenScrolling = true
        self.navigationItem.searchController = searchController

    }

    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupViewCode()
    }

}

extension FourthViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {


    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: firstCellId, for: indexPath) as! CategoryCell
        cell.appCategory = appCategories?[indexPath.item]
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        if let count = appCategories?.count {
            return count
        }
        return 0
    }


    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 300)
    }


    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }





}


// MARK: ViewCode

extension FourthViewController: ViewCode {
    func setupHierarchy() {
        view.addSubview(collectionView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32.0)
        ])
    }
    
    func setupConfiguration() {
        self.view.backgroundColor = UIColor.blue
        self.navigationItem.title = "Products"
    }
    
}
