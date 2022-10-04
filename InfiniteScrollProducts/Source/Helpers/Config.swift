//
//  Config.swift
//  InfiniteScrollProducts
//
//  Created by Fabio Silvestri on 04/10/22.
//  Copyright © 2022 fabiosvt, Inc. All rights reserved.
//

import Foundation

struct Config: Decodable {
    
    let productionApiKey: String
    let productionDomain: String

    let devApiKey: String
    let devDomain: String

}

struct ConfigValues {
    
    static var get: Config {
        get {
            let configFileName = "Config"
            guard let url = Bundle.main.url(forResource: configFileName, withExtension: "plist") else {
                fatalError("Config.plist not found")
            }
            do {
                let data = try Data(contentsOf: url)
                let decoder = PropertyListDecoder()
                
                return try decoder.decode(Config.self, from: data)
            } catch let error {
                fatalError(error.localizedDescription)
            }
        }
    }
}
