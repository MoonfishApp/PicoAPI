//
//  Models.swift
//  
//
//  Created by Ronald Mannak on 2/13/23.
//

import Foundation
import OpenAIKit

struct Request: Codable {
    let userID: String
//    let prompt: String
    let messages: [Chat.Message]
    let maxTokens: Int
    let temperature: Double
}

struct Response: Codable {
    let completion: String?
    let OpenAIErrorMessage: String?
}
