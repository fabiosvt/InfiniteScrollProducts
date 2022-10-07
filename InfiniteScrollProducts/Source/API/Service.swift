//
//  Service.swift
//  InfiniteScrollProducts
//
//  Created by Fabio Silvestri on 03/10/22.
//  Copyright © 2022 fabiosvt, Inc. All rights reserved.
//

import Foundation

protocol Service {
    
    typealias APIServiceResponse = (Bool, [ServiceError]?, Codable?) -> ()
    
    func fetchProducts(request: APIRequest, _ completion: @escaping APIServiceResponse)

}
