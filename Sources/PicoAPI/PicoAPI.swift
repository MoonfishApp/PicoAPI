import Foundation
import AWSLambdaRuntime
import AWSLambdaEvents
import OpenAIKit

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
    
    let client = OpenAIClient()
    
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
