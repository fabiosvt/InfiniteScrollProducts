//
//  ViewControllerCell.swift
//  InfiniteScrollProducts
//
//  Created by Fabio Silvestri on 04/10/22.
//  Copyright © 2022 fabiosvt, Inc. All rights reserved.
//

import UIKit

class ViewControllerCell: UICollectionViewCell {
    var product: Product?
    var columnNames: Array<Any>?

    weak var delegate: FirstViewControllerDelegate?
    
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

extension ViewControllerCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let columnNames = columnNames else {
            return 0
        }
        return columnNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellTypes.viewControllerCellDetails.description, for: indexPath) as? DetailsCell, let product = product, let columnNames = columnNames else {
            fatalError("Unable to dequeue subclassed cell")
        }
        cell.product = product
        if let column = columnNames[indexPath.row] as? (String, Any) {
            cell.field = column.0
        }
        cell.delegate = delegate
        cell.setupViewCode()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let columnNames = columnNames, let column = columnNames[indexPath.row] as? (String, Any), let productName = product?.value(for: column.0) else {
            fatalError("Unable to dequeue subclassed cell")
        }
        let label = UILabel(frame: CGRect.zero)
        label.text = "\(productName)"
        label.sizeToFit()
        return CGSize(width: label.frame.width, height: 90)
    }
}
