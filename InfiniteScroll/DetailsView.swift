//
//  DetailsView.swift
//  infiniteScroll
//
//  Created by Fabio Silvestri on 29/09/22.
//

import Foundation

class DetailsView: DetailsViewDelegate {
    func goToProductDetail(didSelect infiniteProduct: String, atIndex index: Int) {
        let apiCaller = APICaller()
        apiCaller.fetchData(completion: { [weak self] result in
            switch result {
            case .success(let data):
                print(data)
            case .failure(_):
                print("failure")
            }
        })
    }
}
