//
//  TaskFSSP.swift
//  federalRegistryClient
//
//  Created by cladendas on 24.06.2021.
//

import Foundation

struct TaskFSSP: Codable {
    private(set) var status: String
    private(set) var code: Int
    private(set) var exception: String
    private(set) var response: Response?
    
    init?(json: Dictionary <String, Any>) {
        guard
            let status = json["json"] as? String,
            let code = json["code"] as? Int,
            let exception = json["exception"] as? String,
            let response = json["response"] as? Dictionary <String, Any>
        else { return nil }
        
        self.status = status
        self.code = code
        self.exception = exception
        self.response = Response(json: response)
    }
}

struct Response: Codable {
    private(set) var task: String
    
    init?(json: Dictionary <String, Any>) {
        guard
            let task = json["task"] as? String
        else { return nil }

        self.task = task
    }
}
