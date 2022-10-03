//
//  APICaller.swift
//  infiniteScroll
//
//  Created by Fabio Silvestri on 29/09/22.
//

import Foundation
class APICaller {
    var isPaginating = false
    let itemsToDownload = 20
    func fetchData(pagination:Bool = false, completion: @escaping (Result<[Product], Error>) -> Void) {
        isPaginating = true
        let session = URLSession.shared
        if let url = URL(string: "https://dummyjson.com/products?limit=\(itemsToDownload)") {
            let task = session.dataTask(with: url, completionHandler: { data, response, error in
                if let error = error {
                    completion(.failure(error))
                }
                if let data = data {
                    do {
                        let response = try JSONDecoder().decode(Products.self, from: data)
                        debugPrint(response.limit, response.skip, response.total)
                        completion(.success(response.products))
                    } catch let decoderError {
                        print(decoderError)
                        completion(.failure(decoderError))
                    }
               }
            })
            task.resume()
            self.isPaginating = false
        }
    }
}
