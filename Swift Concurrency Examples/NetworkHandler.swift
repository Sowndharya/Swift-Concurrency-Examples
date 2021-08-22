//
//  NetworkHandler.swift
//  NetworkHandler
//
//  Created by Sowndharya Maheswaran on 18/07/21.
//

import Foundation
import UIKit

enum NetworkError: Error {
    case urlError
    case urlSessionError
}

struct NetworkHandler {

    static func downloadFile(urlString: String) async throws -> Data {
        let url = URL(string: urlString)
        guard let url = url else {
            throw NetworkError.urlError
        }
        return try await downloadFile(url: url)
    }
    
    static func downloadFile(url: URL) async throws -> Data {
        let urlRequest = URLRequest(url: url)
        let (data, _) = try await URLSession.shared.data(for: urlRequest, delegate: nil)
        return data
    }
}
