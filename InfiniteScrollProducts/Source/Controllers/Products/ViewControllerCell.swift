//
//  ViewControllerCell.swift
//  InfiniteScrollProducts
//
//  Created by Fabio Silvestri on 04/10/22.
//  Copyright © 2022 fabiosvt, Inc. All rights reserved.
//

import UIKit

class ViewControllerCell: UICollectionViewCell {
    var data: Product?
    let datas2:Product = Product(title: "Title", description: "Description", brand: "Brand", category: "Category", thumbnail: "Thumbnail")
    let headers = ["Title", "Description", "Brand", "Category", "Thumbnail"]

    weak var delegate: ViewControllerDelegate?
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = CGSize(width: 150, height: 150)
        layout.scrollDirection = .horizontal
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViewCode()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: ViewCode

extension ViewControllerCell: ViewCode {
    func setupHierarchy() {
        contentView.addSubview(collectionView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            collectionView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -32.0)
        ])
    }
    
    func setupConfiguration() {
        collectionView.register(DetailsCell.self, forCellWithReuseIdentifier: CollectionViewCellTypes.viewControllerCellDetails.description)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
}

extension ViewControllerCell: UICollectionViewDelegate, UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let data = data else { return 0 }
        return headers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellTypes.viewControllerCellDetails.description, for: indexPath) as? DetailsCell, let data = data {
            cell.product = datas2
            cell.delegate = delegate
            cell.setupViewCode()
            return cell
        }
        fatalError("Unable to dequeue subclassed cell")
    }
}
