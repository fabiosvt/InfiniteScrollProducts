//
//  CollectionViewCellTypes.swift
//  InfiniteScrollProducts
//
//  Created by Fabio Silvestri on 05/10/22.
//  Copyright © 2022 fabiosvt, Inc. All rights reserved.
//

import Foundation

enum CollectionViewCellTypes {
    case viewControllerCell
    case viewControllerCellDetails
    case viewControllerHeaderCell
    case customCell
    case headerView
    case contentCellIdentifier
    
    var description: String {
        switch self {
        case .viewControllerCell:
            return "viewControllerCell"
        case .viewControllerCellDetails:
            return "viewControllerCellDetails"
        case .viewControllerHeaderCell:
            return "viewControllerHeaderCell"
        case .customCell:
            return "CustomCell"
        case .headerView:
            return "HeaderView"
        case .contentCellIdentifier:
            return "ContentCellIdentifier"
        }
    }
}
