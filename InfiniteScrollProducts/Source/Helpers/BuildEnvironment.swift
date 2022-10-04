//
//  BuildEnvironment.swift
//  InfiniteScrollProducts
//
//  Created by Fabio Silvestri on 04/10/22.
//  Copyright © 2022 fabiosvt, Inc. All rights reserved.
//

import Foundation

enum BuildEnvironment: String {
    
    case development, production
    
    var staticContentBaseURL : String {
        switch self {
        case .development:
            return ConfigValues.get.devDomain
        case .production:
            return ConfigValues.get.productionDomain
        }
    }
    
    var staticApiKey: String {
        switch self {
        case .development:
            return ConfigValues.get.devApiKey
        case .production:
            return ConfigValues.get.productionApiKey
        }
    }

}
