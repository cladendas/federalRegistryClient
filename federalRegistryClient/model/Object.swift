//
//  Object.swift
//  federalRegistryClient
//
//  Created by cladendas on 22.06.2021.
//

import Foundation

///Объект недвижимости
struct Object: Codable {
    private(set) var addressNotes: String
    
    init? (json: Dictionary <String, Any>) {
        guard
            let addressNotes = json["addressNotes"] as? String
        else { return nil }
        
        self.addressNotes = addressNotes
    }
}
