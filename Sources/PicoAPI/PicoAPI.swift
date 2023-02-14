import Foundation
import AWSLambdaRuntime
import AWSLambdaEvents
import OpenAIKit
import NIOFoundationCompat

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
    func handle(_ request: Request, context: LambdaContext) async throws -> Response {
        print("Received: \(request)")
        let completion = try await openAICall(request: request)
        print("response: \(completion)")
        return completion
    }
    
    func openAICall(request: Request) async throws -> Response {
        let completion = try await client.completion(prompt: request.prompt, maxTokens: request.maxTokens, temperature: request.temperature)
        return completion
    }
}
