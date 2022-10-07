//
//  FeaturedVerticalCell.swift
//  InfiniteScrollProducts
//
//  Created by Fabio Silvestri on 10/10/22.
//  Copyright © 2022 fabiosvt, Inc. All rights reserved.
//

import UIKit

struct Titles {
    var title: String?
    var images:[String]
}


class FeaturedVerticalCell: UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    let horizontalCellId = "horizontalCellId"


    var appCategory: AppCategory? {
        didSet {
            if let name = appCategory?.name {
                titleLabel.text = name
            }
        }
    }



    let horizontalCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()




    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        if UIDevice.current.userInterfaceIdiom == .phone {
            label.font = UIFont.systemFont(ofSize: 14.0, weight: UIFont.Weight.medium)
        } else {
            label.font = UIFont.systemFont(ofSize: 20.0, weight: UIFont.Weight.medium)
        }
        label.textAlignment = .left
        label.textColor = UIColor.darkGray
        return label
    }()



    override init(frame: CGRect) {
        super.init(frame: frame)

        horizontalCollectionView.dataSource = self
        horizontalCollectionView.delegate = self
        horizontalCollectionView.register(HorizontalCollectionViewCell.self, forCellWithReuseIdentifier: horizontalCellId)


        addSubview(horizontalCollectionView)
        horizontalCollectionView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 24).isActive = true
        horizontalCollectionView.topAnchor.constraint(equalTo: self.topAnchor, constant: 36).isActive = true
        horizontalCollectionView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -24).isActive = true
        horizontalCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 8).isActive = true



        addSubview(titleLabel)
        titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 24).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -24).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: horizontalCollectionView.topAnchor, constant: 0).isActive = true
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 24).isActive = true





    }


    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }



  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = appCategory?.apps?.count {
            return count
        }

        return 0

    }




    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: horizontalCellId, for: indexPath) as! HorizontalCollectionViewCell
        cell.app = appCategory?.apps?[indexPath.item]
        return cell


    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.height * 4 / 5, height: frame.height * 4 / 5)
    }



}

