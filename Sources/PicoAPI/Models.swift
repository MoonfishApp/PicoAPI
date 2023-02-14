//
//  Models.swift
//  
//
//  Created by Ronald Mannak on 2/13/23.
//

import Foundation

struct Request: Codable {
    let userID: String
    let prompt: String
    let maxTokens: Int
    let temperature: Double
}

struct Response: Codable {
    let completion: String
}
