//
//  ViewCode.swift
//  InfiniteScrollProducts
//
//  Created by Fabio Silvestri on 30/09/22.
//

import Foundation

protocol ViewCode: AnyObject {
    func setupViewCode()
    func setupHierarchy()
    func setupConstraints()
    func setupConfiguration()
}

extension ViewCode {
    func setupViewCode() {
        setupHierarchy()
        setupConstraints()
        setupConfiguration()
    }
}
