//
//  ViewController.swift
//  URLSessionClass
//
//  Created by Gerardo Valencia on 19/05/22.
//

import UIKit

class ViewController: UIViewController {

    let getURL: String = "https://pokeapi.co/api/v2/pokemon/totodile"
    let postURL: String = "https://jsonplaceholder.typicode.com/posts"
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.sendGetDataRequest()
//        self.sendGetJSONRequest()
//        self.sendPostDataRequest()
//        self.sendPostJSONRequest()
    }
    
    // ------------------------------
    // MARK: API USED
    // ------------------------------
    let apiURLUsed: String = "https://jsonplaceholder.typicode.com"
    
    // ------------------------------
    // MARK: REQUESTS OBJECT
    // ------------------------------
    
    let postObject = ModelPostObject(id: 1, title: "Post title", body: "Post body", userId: 1)
    
    // ------------------------------
    // MARK: HEADER OBJECTS
    // ------------------------------
    let postHeaders = ["Content-type": "application/json; charset=UTF-8"]
    
    // ------------------------------
    // MARK: DATA REQUESTS FUNCTIONS
    // ------------------------------
    
    func sendGetDataRequest() {
        
        URLSessionService.sharedInstance().sendGetRequestForData(URLString: self.getURL) { (errorMessage, data) in
            
            if let errorMessage = errorMessage {
                print("ERROR: \(errorMessage)")
            } else if let data = data {
                
                do {
                    let pokemonModel = try JSONDecoder().decode(ModelGetObject.self, from: data)
                    print(pokemonModel)
                } catch {
                    print("Error decoding: \(error.localizedDescription)")
                }
                
            } else {
                print("Unknown error")
            }
            
        }
        
    }
    
    func sendPostDataRequest() {
        
        do {
        
            let (errorMessage, postDict) = try self.postObject.toDictionary()
            
            if let errorMessage = errorMessage {
                print(errorMessage)
            } else if let postDict = postDict {
                
                URLSessionService.sharedInstance().sendPostRequestForData(URLString: self.postURL, headers: self.postHeaders, payload: postDict) { errorMessage, data in
                    
                    if let errorMessage = errorMessage {
                        print(errorMessage)
                    } else {
                        
                        if let data = data {
                            
                            do {
                                let postModel = try JSONDecoder().decode(ModelPostObject.self, from: data)
                                print(postModel)
                            } catch {
                                print("Error decoding: \(error.localizedDescription)")
                            }
                            
                        } else {
                            print("Unknown error")
                        }
                        
                    }
                    
                }
                
            } else {
                print("Unknown error")
            }
            
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
    // ------------------------------
    // MARK: JSON REQUESTS FUNCTIONS
    // ------------------------------

    func sendGetJSONRequest() {
        
        URLSessionService.sharedInstance().sendGetRequestForJSON(URLString: self.getURL) { errorMessage, jsonDict in
            
            if let errorMessage = errorMessage {
                print("ERROR: \(errorMessage)")
            } else if let jsonDict = jsonDict {
                print(jsonDict)
            } else {
                print("Unknown error")
            }
            
        }
        
    }
    
    func sendPostJSONRequest() {
        
        do {
            
            let (errorMessage, postDict) = try self.postObject.toDictionary()
            
            if let errorMessage = errorMessage {
                print(errorMessage)
            } else if let postDict = postDict {
                
                URLSessionService.sharedInstance().sendPostRequestForJSON(URLString: self.postURL, headers: self.postHeaders, payload: postDict) { errorMessage, jsonDict in
                    
                    if let errorMessage = errorMessage {
                        print(errorMessage)
                    } else  if let jsonDict = jsonDict {
                        print(jsonDict)
                    } else {
                        print("Unknown error")
                    }
                    
                }
                
            } else {
                print("Unknown error")
            }
            
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
}

// ------------------------------
// MARK: SWIFT EXTENSIONS
// ------------------------------

extension Data {
    
    func getPrettyPrintedJSONString() -> String {
        
        do {
            
            let jsonObject = try JSONSerialization.jsonObject(with: self)
            let data = try JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted)
            return String(decoding: data, as: UTF8.self)
            
        } catch {
            return error.localizedDescription
        }
        
    }
    
    func toNullableValuesDict() -> Dictionary<String, Any?>? {
        
        do {
            
            if let dict = try JSONSerialization.jsonObject(with: self) as? Dictionary<String, Any?> {
                return dict
            } else {
                return nil
            }
            
        } catch {
            print(error.localizedDescription)
            return nil
        }
        
    }
    
}

extension Dictionary {
    
    func toData() throws -> (errorMessage: String?, data: Data?) {
        
        do {
            let data = try JSONSerialization.data(withJSONObject: self)
            return (nil, data)
        } catch {
            return (error.localizedDescription, nil)
        }
        
    }
    
}

extension Encodable {
    
    func toDictionary() throws -> (errorMessage: String?, dict: [String: Any]?) {
        
        do {
            
            let data = try JSONEncoder().encode(self)
            let dict = try JSONSerialization.jsonObject(with: data)
            
            if let dict = dict as? [String: Any] {
                return (nil, dict)
            } else {
                return ("Error encoding", nil)
            }
            
        } catch {
            return (error.localizedDescription, nil)
        }
        
    }
    
}

