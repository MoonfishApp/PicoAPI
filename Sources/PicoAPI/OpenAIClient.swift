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
    static let apiKey = APIKey.key
    static let organization = APIKey.organization
    private let openAI: OpenAIKit.Client
    
    init() {
        let httpClient = HTTPClient(eventLoopGroupProvider: .createNew)
        let configuration = Configuration(apiKey: OpenAIClient.apiKey, organization: OpenAIClient.organization)
        openAI = OpenAIKit.Client(httpClient: httpClient, configuration: configuration)
    }
    
    func completion(prompt: String) async throws -> String {
        let completion = try await openAI.completions.create(
            model: Model.GPT3.davinci,
            prompts: [prompt]
        )
        guard let result = completion.choices.first?.text else {
            throw ClientError.emptyResult
        }
        return result
    }
    
    /*
     public func create(
         model: ModelID,
         prompts: [String] = [],
         suffix: String? = nil,
         maxTokens: Int = 16,
         temperature: Double = 1.0,
         topP: Double = 1.0,
         n: Int = 1,
         stream: Bool = false,
         logprobs: Int? = nil,
         echo: Bool = false,
         stops: [String] = [],
         presencePenalty: Double = 0.0,
         frequencyPenalty: Double = 0.0,
         bestOf: Int = 1,
         logitBias: [String : Int] = [:],
         user: String? = nil
     ) async throws -> Completion {
     */
//    try await OpenAIClient().completion(prompt: "what is the answer to life, the universe and everything?")
}
