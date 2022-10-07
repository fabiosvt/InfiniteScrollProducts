//
//  APIService.swift
//  InfiniteScrollProducts
//
//  Created by Fabio Silvestri on 03/10/22.
//  Copyright © 2022 fabiosvt, Inc. All rights reserved.
//

import Foundation
import Combine

public class APIService: Service {
    private let client = APIClient()
    
    func fetchProducts(request: APIRequest, limit: Int, _ completion: @escaping APIServiceResponse) {
        client.perform(request) { result in
            switch result {
            case .success(let response):
                do {
                    let json = try JSONDecoder().decode(Products.self, from: response)
                    completion(true, nil, json)
                } catch {
                    let serviceError = [ServiceError(code: "", field: "", message: "Error decoding JSON")]
                    completion(false, serviceError, nil)
                }
                
            case .failure(let error):
                let serviceError = [ServiceError(code: String(error.hashValue), field: "", message: error.localizedDescription)]
                completion(false, serviceError, nil)
            }
        }
        client.dispatchGroup.wait()
    }
    
}
