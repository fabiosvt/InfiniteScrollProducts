//
//  APIResponseHandler.swift
//  InfiniteScrollProducts
//
//  Created by Fabio Silvestri on 03/10/22.
//  Copyright © 2022 fabiosvt, Inc. All rights reserved.
//

import Foundation

class APIResponseHandler {
    
    private var httpURLResponse: HTTPURLResponse?
    var statusCode: Int? {
        return httpURLResponse?.statusCode
    }
    
    var code: String?  {
        
        guard let httpURLResponse = self.httpURLResponse else {
            return nil
        }
        
        guard let location = httpURLResponse.url?.absoluteString else {
            return nil
        }

        let temp = location.split(separator: "?")
        
        guard temp.count >= 2 else {
            return nil
        }
        
        let params = temp[1].split(separator: "&")
        
        for p in params {
            let temp = p.split(separator: "=")
            guard temp.count == 2 else {
                continue
            }
            
            if temp[0] == "code" {
                return String(temp[1])
            } else {
                continue
            }
        }
        
        return nil
    }
    
    func processHTTPURLResponse(httpURLResponse: HTTPURLResponse) {
        self.httpURLResponse = httpURLResponse
    }
    
}
