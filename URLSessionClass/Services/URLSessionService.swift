//
//  URLSessionService.swift
//  URLSessionClass
//
//  Created by Gerardo Valencia on 19/05/22.
//

import Foundation

private let _urlSessionService : URLSessionService! = URLSessionService()

class URLSessionService {
    
    open class func sharedInstance() -> URLSessionService! {
        return _urlSessionService;
    }
    
    // ----------------------------
    // MARK: DATA REQUESTS
    // ----------------------------
    
    /// Get request for Data
    /// - Parameters:
    ///   - URLString: Literal string for url
    ///   - completion: errorMessage and data returned
    func sendGetRequestForData(URLString: String, completion: ((_ errorMessage: String?, _ data: Data?) -> Void)?) {
        
        do {
            
            let (errorMessage, requestURL) = try URLRequestHelper().createURLRequest(url: URLString)
            
            if let errorMessage = errorMessage {
                
                if let completion = completion {
                    completion(errorMessage, nil)
                }
                
            } else if let requestURL = requestURL {
                
                let getRequestForDataTask = URLSession.shared.dataTask(with: requestURL) { (data, response, error) in
                    
                    if let error = error {
                        
                        if let completion = completion {
                            completion("Error returned from request: \(error.localizedDescription)", nil)
                        }
                        
                    } else {
                        
                        if let response = response as? HTTPURLResponse,
                           let data = data {
                            
                            if (response.statusCode == GET_STATUS_CODE_SUCCESSFUL) {
                                
                                if let completion = completion {
                                    completion(nil, data)
                                }
                                
                            } else {
                                
                                if let completion = completion {
                                    completion("Request failed status code not 200", nil)
                                }
                                
                            }
                            
                        }
                        
                    }
                    
                }
                
                getRequestForDataTask.resume()
                
            } else {
                
                if let completion = completion {
                    completion("Unknown error", nil)
                }
                
            }
            
        } catch {
            
        }
        
    }
    
    
    /// Post request for Data
    /// - Parameters:
    ///   - URLString: Literal string for url
    ///   - payload: HTTP body to send
    ///   - completion: errorMessage and data returned
    func sendPostRequestForData(URLString: String, headers: Dictionary<String, String>, payload: Dictionary<String, Any>, completion: ((_ errorMessage: String?, _ data: Data?) -> Void)?) {
        
        do {
            
            let (errorMessage, postRequest) = try URLRequestHelper().createURLRequest(url: URLString, httpMethod: HTTP_POST, headers: headers, payload: payload)
            
            if let errorMessage = errorMessage {
                
                if let completion = completion {
                    completion(errorMessage, nil)
                }
                
            } else if let postRequest = postRequest {
                
                let postRequestForDataTask = URLSession.shared.dataTask(with: postRequest) { (data, response, error) in
                    
                    if let error = error {
                        
                        if let completion = completion {
                            completion("Error returned from request: \(error.localizedDescription)", nil)
                        }
                        
                    } else {
                        
                        if let response = response as? HTTPURLResponse,
                           let data = data {
                            
                            if (response.statusCode == POST_STATUS_CODE_SUCCESSFUL) {
                                
                                if let completion = completion {
                                    completion(nil, data)
                                }
                                
                            } else {
                                
                                if let completion = completion {
                                    completion("Request failed status code not 201", nil)
                                }
                                
                            }
                            
                        }
                        
                    }
                    
                }
                
                postRequestForDataTask.resume()
                
            } else {
                
                if let completion = completion {
                    completion("Unknown error", nil)
                }
                
            }
            
        } catch {
         
            if let completion = completion {
                completion(error.localizedDescription, nil)
            }
            
        }
        
    }
    
    // ----------------------------
    // MARK: JSON REQUESTS
    // ----------------------------
    
    /// Get request for JSON
    /// - Parameters:
    ///   - URLString: Literal string for url
    ///   - completion: errorMessage and jsonDict returned
    func sendGetRequestForJSON(URLString: String, completion: ((_ errorMessage: String?, _ jsonDict: [String: Any?]?) -> Void)?) {
        
        do {
            
            let (errorMessage, requestURL) = try URLRequestHelper().createURLRequest(url: URLString)
            
            if let errorMessage = errorMessage {
                
                if let completion = completion {
                    completion(errorMessage, nil)
                }
                
            } else if let requestURL = requestURL {
                
                let getRequestForDataTask = URLSession.shared.dataTask(with: requestURL) { (data, response, error) in
                    
                    if let error = error {
                        
                        if let completion = completion {
                            completion("Error returned from request: \(error.localizedDescription)", nil)
                        }
                        
                    } else {
                        
                        if let response = response as? HTTPURLResponse,
                           let data = data {
                            
                            if (response.statusCode == GET_STATUS_CODE_SUCCESSFUL) {
                                
                                if let dict = data.toNullableValuesDict() {
                                    
                                    if let completion = completion {
                                        completion(nil, dict)
                                    }
                                    
                                } else {
                                    
                                    if let completion = completion {
                                        completion("Error converting data to JSON object", nil)
                                    }
                                    
                                }
                                
                            } else {
                                
                                if let completion = completion {
                                    completion("Request failed status code not 200", nil)
                                }
                                
                            }
                            
                        }
                        
                    }
                    
                }
                
                getRequestForDataTask.resume()
                
            } else {
                
                if let completion = completion {
                    completion("Unknown error", nil)
                }
                
            }
            
        } catch {
            
            if let completion = completion {
                completion(error.localizedDescription, nil)
            }
            
        }
        
    }
    
    func sendPostRequestForJSON(URLString: String, headers: Dictionary<String, String>, payload: Dictionary<String, Any>, completion: ((_ errorMessage: String?, _ jsonDict: [String: Any?]?) -> Void)?) {
        
        do {
            
            let (errorMessage, postRequest) = try URLRequestHelper().createURLRequest(url: URLString, httpMethod: HTTP_POST, headers: headers, payload: payload)
            
            if let errorMessage = errorMessage {
                
                if let completion = completion {
                    completion(errorMessage, nil)
                }
                
            } else if let postRequest = postRequest {
                
                let postRequestForDataTask = URLSession.shared.dataTask(with: postRequest) { (data, response, error) in
                    
                    if let error = error {
                        
                        if let completion = completion {
                            completion("Error returned from request: \(error.localizedDescription)", nil)
                        }
                        
                    } else {
                        
                        if let response = response as? HTTPURLResponse,
                           let data = data {
                            
                            if (response.statusCode == POST_STATUS_CODE_SUCCESSFUL) {
                                
                                if let dict = data.toNullableValuesDict() {
                                    
                                    if let completion = completion {
                                        completion(nil, dict)
                                    }
                                    
                                } else {
                                    
                                    if let completion = completion {
                                        completion("Error converting data to JSON object", nil)
                                    }
                                    
                                }
                                
                            } else {
                                
                                if let completion = completion {
                                    completion("Request failed status code not 201", nil)
                                }
                                
                            }
                            
                        }
                        
                    }
                    
                }
                
                postRequestForDataTask.resume()
                
            } else {
                
                if let completion = completion {
                    completion("Unknown error", nil)
                }
            }
            
        } catch {
         
            if let completion = completion {
                completion(error.localizedDescription, nil)
            }
            
        }
        
    }
    
}
