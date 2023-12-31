//
//  NetworkingManager.swift
//  CryptoLive
//
//  Created by Dev Patel on 8/8/23.
//

import Combine
import Foundation

class NetworkingManager {
    enum NetworkError: LocalizedError {
        case badURLResponse(url: URL)
        case unknown
        
        var errorDescription: String? {
            switch self {
            case .badURLResponse(url: let url):
                return "❌ Bad response from the URL: \(url)"
            case .unknown:
                return "⚠️ Unknown error occured"
            }
        }
    }
    
    static func download(url: URL) -> AnyPublisher<Data, any Error> {
        // download data in the background and return it on the main thread
        return URLSession.shared.dataTaskPublisher(for: url)
                    .tryMap { try handleURLResponse(output: $0, url: url) }
                    .retry(3)
                    .eraseToAnyPublisher()
    }
    
    static func handleURLResponse(output: URLSession.DataTaskPublisher.Output, url: URL) throws -> Data {
        guard let response = output.response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else {
            throw NetworkError.badURLResponse(url: url)
        }
        return output.data
    }
    
    static func handleCompletion(completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished:
            break
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
}
