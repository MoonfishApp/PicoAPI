//
//  main.swift
//  
//
//  Created by Ronald Mannak on 2/10/23.
//

import Foundation
import AWSLambdaRuntime

struct Input: Codable {
    let name: String
}

struct Output: Codable {
    let message: String
}

Lambda.run { (context, input: Input, completion: @escaping (Result<Output, Error>) -> Void) in
    completion(.success(Output(message: "Hello \(input.name)")))
}
