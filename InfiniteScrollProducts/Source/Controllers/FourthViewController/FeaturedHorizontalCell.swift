//
//  FeaturedHorizontalCell.swift
//  InfiniteScrollProducts
//
//  Created by Fabio Silvestri on 10/10/22.
//  Copyright © 2022 fabiosvt, Inc. All rights reserved.
//

import UIKit


class HorizontalCollectionViewCell: UICollectionViewCell {

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
        iv.layer.cornerRadius = 10
        iv.image = #imageLiteral(resourceName: "IMG_2545")
        iv.layer.masksToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(photoImageView)
        photoImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        photoImageView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        photoImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        photoImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}

