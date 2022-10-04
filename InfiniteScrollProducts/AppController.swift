//
//  AppController.swift
//  InfiniteScrollProducts
//
//  Created by Fabio Silvestri on 03/10/22.
//  Copyright © 2022 fabiosvt, Inc. All rights reserved.
//

import Foundation

class AppController {
    
    let buildEnviornment = buildEnv()
    
    static func buildEnv() -> BuildEnvironment {
        if let plistValue = Bundle.main.infoDictionary?["buildEnv"] as? String, let env = BuildEnvironment(rawValue: plistValue) {
            return env
        } else {
            return BuildEnvironment.development
        }
    }

    static let sharedInstance: AppController = {
        let instance = AppController()
        return instance
    }()

}
