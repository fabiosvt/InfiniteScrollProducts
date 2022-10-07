//
//  APIClient.swift
//  InfiniteScrollProducts
//
//  Created by Fabio Silvestri on 03/10/22.
//  Copyright © 2022 fabiosvt, Inc. All rights reserved.
//

import Foundation

enum APIError: Error {
    case invalidURL
    case requestFailed
    case authRequired
    
}

class APIErrorCodeConstants {
    static let authRequired: String = "AUTH_REQUIRED"

    static func allAuthRequiredErrorCodes() -> [String] {
        return [authRequired]
    }
   
}

enum APIResult<Body> {
    case success(Data)
    case failure(APIError)
}

typealias APIRefreshTokenResponse = (Bool, [ServiceError]?, Codable?) -> ()

struct APIClient {
    
    typealias APIClientCompletion = (APIResult<Data?>) -> Void
    
    private let session: URLSession = {
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .reloadIgnoringLocalCacheData
        config.waitsForConnectivity = false
        config.timeoutIntervalForRequest = 30
        config.timeoutIntervalForResource = 60
        config.urlCache = nil
        let _session = URLSession.init(configuration: config)
        
        return _session
    }()

    var httpURLResponse: HTTPURLResponse?
    let apiResponseHandler = APIResponseHandler()
            
    func perform(_ request: APIRequest, _ completion: @escaping APIClientCompletion) {
        guard let baseURL = URL(string: request.url) else {
            completion(.failure(.invalidURL))
            return
        }
        var urlComponents = URLComponents()
        urlComponents.scheme = baseURL.scheme
        urlComponents.host = baseURL.host
        urlComponents.path = baseURL.path
        urlComponents.port = baseURL.port
        urlComponents.queryItems = request.queryItems
        
        guard let url = urlComponents.url else {
            completion(.failure(.invalidURL))
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.httpMethod.stringValue().uppercased()
        urlRequest.httpBody = request.body
        
        request.headers.forEach { urlRequest.addValue($0.value, forHTTPHeaderField: $0.field) }
        
        self.logRequest(request: request)
        
        let task = session.dataTask(with: url, completionHandler: { (data, response, error) in
            guard let httpURLResp = response as? HTTPURLResponse else {
                if let error = error {
                    logErrorMessages(error: error)
                }
                completion(.failure(.requestFailed))
                return
            }
            apiResponseHandler.processHTTPURLResponse(httpURLResponse: httpURLResp)
            
            guard let result = data else {
                if let error = error {
                    logErrorMessages(error: error)
                }
                completion(.failure(.requestFailed))
                return
            }
            
            self.logResponse(response: result, request: request)
            
            if let jsonResult = try? JSONDecoder().decode(ServiceErrorResponse.self, from: result) as ServiceErrorResponse,
               let issues = jsonResult.issues, !issues.isEmpty,
               let statusCode = apiResponseHandler.statusCode, statusCode != 200 && statusCode != 201 {
                let issue = issues.first!
                guard let code = issue.code else {
                    completion(.failure(.requestFailed))
                    return
                }
                
                switch code {
                case APIErrorCodeConstants.authRequired:
                    completion(.failure(.authRequired))
                default:
                    completion(.failure(.requestFailed))
                }
                return
            }
            completion(.success(result))
        })
        task.resume()
    }
        
    // MARK: - Log
    
    private func logRequest(request: APIRequest) {
#if DEBUG
        print("## START REQUEST")
        print("Request URL: \(request.url)")
        print("Request METHOD: \(request.httpMethod)")
        print("Request HEADERS: \(String(describing: request.headers))")
        
        if let data = request.body {
            let str = String(decoding: data, as: UTF8.self)
            let strArr = str.components(separatedBy: "Content-Disposition")
            if strArr.count > 1 {
                print("Request BODY decoded data: \(strArr[0])")
                print("Request BODY decoded data: \(strArr[1])")
            } else {
                print("Request BODY decoded data: \(str)")
            }
        } else {
            print("Request BODY: \(String(describing: request.body))")
        }
#endif
    }
    
    private func logResponse(response: Data, request: APIRequest) {
#if DEBUG
        print("## START RESPONSE")
        print("Status code: \(apiResponseHandler.statusCode ?? 0)")
        print("Request URL: \(request.url) ")
        print("Request METHOD: \(request.httpMethod) ")
        print("Request HEADERS: \(String(describing: request.headers))")
        print("Response decoded: \(String(data: response, encoding: .utf8) ?? "")")
#endif
    }
        
    private func logErrorMessages(error: Error) {
#if DEBUG
        print("## START RESPONSE ERRORS")
        print("Status code: \(apiResponseHandler.statusCode ?? 0)")
        print("API Client Error: \(error.localizedDescription)")
#endif
    }
    
}
