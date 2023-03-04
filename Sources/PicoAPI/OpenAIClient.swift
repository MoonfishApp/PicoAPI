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
    
    func completion(messages: [Chat.Message], temperature: Double = 1.0, maxTokens: Int = 100,  userID: String) async throws -> Chat {
      
        let completion = try await openAI.chats.create(model: Model.GPT3.gpt3_5Turbo, messages: messages, temperature: temperature, maxTokens: maxTokens, user: userID)
        return completion
    }
    
    /*
     
     model: ModelID,
     messages: [Chat.Message] = [],
     temperature: Double = 1.0,
     topP: Double = 1.0,
     n: Int = 1,
     stream: Bool = false,
     stops: [String] = [],
     presencePenalty: Double = 0.0,
     frequencyPenalty: Double = 0.0,
     logitBias: [String : Int] = [:],
     user: String? = nil
     */
    
    /*
    let completion = try await client.chats.create(
          model: Model.GPT3.gpt3_5Turbo,
          messages: [
              Chat.Message(
                  role: "user",
                  content: "Write a haiku"
              )
          ]
      )
    */
    
    
    /*
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
    */
}
