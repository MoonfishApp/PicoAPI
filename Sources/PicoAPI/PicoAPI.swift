import Foundation
import AWSLambdaRuntime
import AWSLambdaEvents
import OpenAIKit

// Request, uses Codable for transparent JSON encoding
struct Request: Codable {
  let name: String
}

// Response, uses Codable for transparent JSON encoding
struct Response: Codable {
  let message: String
}

@main
struct PicoAPI: SimpleLambdaHandler {
    
    func handle(_ request: Request, context: LambdaContext) async throws -> Response {
        print("Received: \(request)")
        let response = Response(message: "Hello, \(request.name)")
        print("Response: \(response)")
        return response
    }
}
