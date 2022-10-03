//
//  ViewCode.swift
//  InfiniteScrollProducts
//
//  Created by Fabio Silvestri on 30/09/22.
//

import Foundation

protocol ViewCode: AnyObject {
    func setupHierarchy()
    func setupConstraints()
    func setupConfiguration()
}
