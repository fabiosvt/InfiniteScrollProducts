//
//  HeaderView.swift
//  InfiniteScrollProducts
//
//  Created by Fabio Silvestri on 10/10/22.
//  Copyright © 2022 fabiosvt, Inc. All rights reserved.
//

import Foundation
import UIKit

class HeaderView: UICollectionReusableView {

    let label = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .magenta

        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
