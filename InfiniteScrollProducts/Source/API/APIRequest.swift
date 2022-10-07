//
//  APIRequest.swift
//  InfiniteScrollProducts
//
//  Created by Fabio Silvestri on 03/10/22.
//  Copyright © 2022 fabiosvt, Inc. All rights reserved.
//

import Foundation

struct HTTPHeader {
    let field: String
    let value: String
}

public enum HTTPMethod: String {
    case options = "OPTIONS"
    case get     = "GET"
    case head    = "HEAD"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
    case trace   = "TRACE"
    case connect = "CONNECT"
}

public enum RequestType {
    case GET
    case PUT
    case POST
    case DELETE
    case PATCH

    internal var httpMethod : HTTPMethod {
        switch self {
         case .GET:
            return .get
        case .POST:
            return .post
        case .PUT:
            return .put
        case .DELETE:
            return .delete
        case .PATCH:
            return .patch
        }
    }
    
   public static func requestTypeFrom(httpMethod: HTTPMethod) -> RequestType  {
        switch httpMethod {
        case .get:
            return .GET
        case .post:
            return .POST
        case .put:
            return .PUT
        case .delete:
            return .DELETE
        case .patch:
            return .PATCH
        default:
            return .GET
        }
    }
    
    public func stringValue() -> String {
        switch self {
        case .GET:
            return "get"
        case .POST:
            return "post"
        case .PUT:
            return "put"
        case .DELETE:
            return "delete"
        case .PATCH:
            return "patch"
        }
    }
    
    public func requestTypeValue(stringValue: String) -> RequestType {
        switch stringValue {
        case "post":
            return .POST
        case "put":
            return .PUT
        case "delete":
            return .DELETE
        case "patch":
            return .PATCH
        default:
            return .GET
        }
    }
}

public enum HeaderType {
    case NoneHeaderType
    case BasicAuthHeaderType
    case TokenAuthHeaderType
}

struct ServiceError: Codable {
    let code, field, message: String?
    
    enum CodingKeys: String, CodingKey {
        case code
        case field
        case message
    }
}

struct ServiceErrorResponse: Codable {
    let issues: [ServiceError]?
    
    enum CodingKeys: String, CodingKey {
        case issues
    }
}

enum APIRequest {
    
    case fetchProducts(limit: Int)
    case fetchProductsApi(limit: Int)
    
    var requestName: String {
        switch self {
        case .fetchProducts:
            return "Fetch products"
            
        case .fetchProductsApi:
            return "Fetch products"
            
        }
    }
    
    private var apiKey: String { AppController.sharedInstance.buildEnviornment.staticApiKey }
    
    var url: String {
        switch self {
        case .fetchProducts:
            return "https://dummyjson.com/\(self.path)"
            
        case .fetchProductsApi:
            return "\(AppController.sharedInstance.buildEnviornment.staticContentBaseURL)\(self.path)"

        }

    }
    
    var path: String {
        
        switch self {
        case .fetchProducts:
            return "products"
            
        case .fetchProductsApi:
            return "api/products.json"
            
        }
    }
    
    var queryItems: [URLQueryItem]? {
        
        switch self {
        case .fetchProducts(let limit):
            return [URLQueryItem(name: "limit", value: String(limit))]
            
        case .fetchProductsApi(let limit):
            return [URLQueryItem(name: "limit", value: String(limit))]
            
        }
    }
    
    var httpMethod: RequestType {
        
        switch self {
        case .fetchProducts:
            return .GET
            
        case .fetchProductsApi:
            return .GET
            
        }
    }
    
    var headers: [HTTPHeader] {
        
        switch self {
        case .fetchProducts:
            return [HTTPHeader(field: "apikey", value: apiKey),
                    HTTPHeader(field: "Content-Type", value: "application/json"),
                    HTTPHeader(field: "Authorization", value: "accessTokenBearer")]
            
        case .fetchProductsApi:
            return [HTTPHeader(field: "apikey", value: apiKey),
                    HTTPHeader(field: "Content-Type", value: "application/json"),
                    HTTPHeader(field: "Authorization", value: "accessTokenBearer")]
            
        }
        
    }
    
    var body: Data? {
        switch self {
        case .fetchProducts(let limit):
            let parameterDictionary = [
                "limit": limit,
                "authId": "authId",
                "sortOrder": [
                    [
                        "title": "asc",
                        "category": "desc"
                    ] as [String: Any]
                ]
            ] as [String: Any]
            guard let body = try? JSONSerialization.data(withJSONObject: parameterDictionary, options: []) else {
                return nil
            }
            return body
            
        case .fetchProductsApi(let limit):
            let parameterDictionary = [
                "limit": limit
            ] as [String: Any]
            guard let body = try? JSONSerialization.data(withJSONObject: parameterDictionary, options: []) else {
                return nil
            }
            return body
        }
    }
    
}
