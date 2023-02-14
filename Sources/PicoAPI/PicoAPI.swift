import Foundation
import AWSLambdaRuntime
import AWSLambdaEvents
import OpenAIKit
import NIOFoundationCompat

// Request, uses Codable for transparent JSON encoding
struct Request: Codable {
  let prompt: String
}

// Response, uses Codable for transparent JSON encoding
struct Response: Codable {
  let message: String
}

@main
struct PicoAPI: SimpleLambdaHandler {
    
    let client: OpenAIClient
    
    init() {
        guard let apiKey = ProcessInfo.processInfo.environment["OPENAI_KEY"],
              let org = ProcessInfo.processInfo.environment["OPENAI_ORG"] else {
            print("Error: missing environment vars")
            client = OpenAIClient(apiKey: "", organization: "")
            return
        }
        client = OpenAIClient(apiKey: apiKey, organization: org)
    }
    
    // http://127.0.0.1:7000/invoke
    // swift package --disable-sandbox archive
    // Can we use environmental vars for the OpenAI API key?
    func handle(_ request: Request, context: LambdaContext) async throws -> Response {
        print("Received: \(request)")
        let completion = try await openAICall(prompt: request.prompt)
        let response = Response(message: completion)
        print("Response: \(response)")
        return response
    }
    
    func openAICall(prompt: String) async throws -> String {
        let completion = try await client.completion(prompt: prompt)
        return completion
    }
}
