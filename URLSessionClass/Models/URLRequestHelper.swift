//
//  URLRequestHelper.swift
//  URLSessionClass
//
//  Created by Gerardo Valencia on 20/05/22.
//

import Foundation

class URLRequestHelper {
    
    func createURLRequest(url: String,
                          cachePolicy: URLRequest.CachePolicy = .reloadIgnoringCacheData,
                          timeoutInterval: TimeInterval = 10,
                          httpMethod: String = HTTP_GET,
                          headers: Dictionary<String, String> = [:],
                          payload: Dictionary<String, Any> = [:]) throws -> (errorMessage: String?, urlRequest: URLRequest?) {
        
        do {

            let (errorMessage, httpPayload) = try payload.toData()

            if let errorMessage = errorMessage {
                return (errorMessage, nil)
            } else if let httpPayload = httpPayload {

                if let urlRequest = URL(string: url) {

                    var request = URLRequest(url: urlRequest, cachePolicy: cachePolicy, timeoutInterval: timeoutInterval)
                    request.httpMethod = httpMethod

                    if (headers.keys.count > 0) {
                        
                        for key in headers.keys {

                            if let headerValue = headers[key] {
                                request.setValue(headerValue, forHTTPHeaderField: key)
                            }

                        }
                        
                    }
                    
                    if (payload.keys.count > 0) {
                        request.httpBody = httpPayload
                    }

                    return (nil, request)

                } else {
                    return ("URL init error", nil)
                }

            } else {
                return ("Unknown error", nil)
            }

        } catch {
            return (error.localizedDescription, nil)
        }
        
    }
    
}
