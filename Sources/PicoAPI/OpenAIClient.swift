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
    private let openAI: OpenAIKit.Client
    
    init(apiKey: String, organization: String) {
        let httpClient = HTTPClient(eventLoopGroupProvider: .createNew)
        let configuration = Configuration(apiKey: apiKey, organization: organization)
        openAI = OpenAIKit.Client(httpClient: httpClient, configuration: configuration)
    }
    
    func completion(prompt: String, maxTokens: Int = 100, temperature: Double = 1.0, userID: String) async throws -> Response {
        do {
            let completion = try await openAI.completions.create(
                model: Model.GPT3.textDavinci003,
                prompts: [prompt],
                maxTokens: maxTokens,
                temperature: temperature,
                user: userID
            )
            guard let result = completion.choices.first?.text else {
                print("Client error empty result")
                throw ClientError.emptyResult
            }
            return Response(completion: result.trimmingCharacters(in: .whitespacesAndNewlines), OpenAIErrorMessage: nil)
        } catch let error as APIErrorResponse {
            print("OpenAI error: \(error.error.type): \(error.error.message)")
            return Response(completion: nil, OpenAIErrorMessage: error.error.message)
        }        
    }
}
