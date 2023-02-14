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

//typealias In = APIGatewayV2Request
//typealias Out = API

@main
struct PicoAPI: SimpleLambdaHandler {
    
    let client = OpenAIClient()
    
    // http://127.0.0.1:7000/invoke
    // swift package --disable-sandbox archive
    // Can we use environmental vars for the OpenAI API key?
    func handle(_ request: Request, context: LambdaContext) async throws -> Response {
//        let response = Response(message: String(request.prompt.reversed()))
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
