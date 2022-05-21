//
//  ModelPostObject.swift
//  URLSessionClass
//
//  Created by Gerardo Valencia on 20/05/22.
//

import Foundation

class ModelPostObject: Encodable, Decodable {
    
    var id: Int = 0
    var title: String = ""
    var body: String = ""
    var userId: Int = 0
    
    init(id: Int, title: String, body: String, userId: Int) {
        self.id = id
        self.title = title
        self.body = body
        self.userId = userId
    }
    
}
