//
//  File.swift
//  
//
//  Created by Ronald Mannak on 2/10/23.
//

import Foundation
import OpenAIKit
import AsyncHTTPClient
import NIO
import NIOHTTP1

enum ClientError: Error {
    case emptyResult
}

final class OpenAIClient {
//    static let apiKey = APIKey.key
//    static let organization = APIKey.organization
    private let openAI: OpenAIKit.Client
    
    init(apiKey: String, organization: String) {
        let httpClient = HTTPClient(eventLoopGroupProvider: .createNew)
        let configuration = Configuration(apiKey: apiKey, organization: organization)
        openAI = OpenAIKit.Client(httpClient: httpClient, configuration: configuration)
    }
    
    func completion(prompt: String, maxTokens: Int = 100, temperature: Double = 1.0) async throws -> Response {
        do {
            let completion = try await openAI.completions.create(
                model: Model.GPT3.textDavinci003,
                prompts: [prompt],
                maxTokens: maxTokens,
                temperature: temperature
            )
            guard let result = completion.choices.first?.text else {
                throw ClientError.emptyResult
            }
            return Response(completion: result.trimmingCharacters(in: .whitespacesAndNewlines), OpenAIErrorMessage: nil)
        } catch let error as APIErrorResponse {
            return Response(completion: nil, OpenAIErrorMessage: error.error.message)
        }        
    }
}
