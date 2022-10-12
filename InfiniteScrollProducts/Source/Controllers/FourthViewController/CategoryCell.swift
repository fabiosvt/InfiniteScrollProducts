//
//  CategoryCell.swift
//  InfiniteScrollProducts
//
//  Created by Fabio Silvestri on 10/10/22.
//  Copyright © 2022 fabiosvt, Inc. All rights reserved.
//

import UIKit

class CategoryCell: UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    var appCategory: AppCategory? {
        didSet {
            if let name = appCategory?.name {
                firstChapterLabel.text = name
            }
        }
    }

    let secondCellId = "secondCellId"


    let appsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    let firstChapterLabel: UILabel = {
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

        addSubview(appsCollectionView)
        appsCollectionView.dataSource = self
        appsCollectionView.delegate = self
        appsCollectionView.register(AppCell.self, forCellWithReuseIdentifier: secondCellId)

        appsCollectionView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16).isActive = true
        appsCollectionView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16).isActive = true
        appsCollectionView.topAnchor.constraint(equalTo: self.topAnchor, constant: 50).isActive = true
        appsCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true

        addSubview(firstChapterLabel)
        firstChapterLabel.leftAnchor.constraint(equalTo: appsCollectionView.leftAnchor, constant: 16).isActive = true
        firstChapterLabel.rightAnchor.constraint(equalTo: appsCollectionView.rightAnchor, constant: -16).isActive = true
        firstChapterLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 24).isActive = true


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

        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: secondCellId, for: indexPath) as! AppCell
        cell.app = appCategory?.apps?[indexPath.item]
        return cell

    }


    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.height, height: frame.height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }



}




class AppCell: UICollectionViewCell {

    var app: App? {
        didSet {
            if let imageName = app?.imageName {
                photoImageView.image = UIImage(named: imageName)
            }
        }
    }


    let photoImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 9
        iv.layer.masksToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()



    override init(frame: CGRect) {
        super.init(frame: frame)


        addSubview(photoImageView)
        photoImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16).isActive = true
        photoImageView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16).isActive = true
        photoImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -36).isActive = true
        photoImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 36).isActive = true




    }



    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}
