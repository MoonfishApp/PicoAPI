import Foundation
import AWSLambdaRuntime

@main
struct PicoAPI: SimpleLambdaHandler {
    
    func handle(_ name: String, context: LambdaContext) async throws -> String {
        "Hello, \(name)"
    }
}
