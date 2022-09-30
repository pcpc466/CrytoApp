//
//  NetworkingManager.swift
//  CryptoTrial
//
//  Created by Prashant Singh chauhan on 8/16/22.
//

import Foundation
import Combine

class NetworkingManager {
    
    enum NetworkingError: LocalizedError {
        case badURLResponse(url: URL)
        case unknown
        
        var errorDescription: String? {
            switch self {
            case .badURLResponse(url: let url): return "bad response from the URL 🥵 \(url)"
            case .unknown: return "Unkown error occurred 🥶"
            }
        }
    }
    
    static func download(url: URL) -> AnyPublisher<Data, Error> {
        
        return URLSession.shared.dataTaskPublisher(for: url)
            /// dont need this as it publisher goes directly to the background thred
//            .subscribe(on: DispatchQueue.global(qos: .default))
           
            /// Made the function or it so we dont need to use this conventional method
//            .tryMap { (output) -> Data in
//                guard let respose = output.response as? HTTPURLResponse,
//                      respose.statusCode >= 200 && respose.statusCode < 300 else {
//                    throw NetworkingError.badURLResponse(url: url)
//                }
//                return output.data
//            }
            .tryMap({try handleURLResponse(output: $0, url: url)})
            /// NUMBER OF TIMES WE WANNA RETRY THE FUNCTION
            .retry(3)
            .eraseToAnyPublisher()
    }
    
    static func handleURLResponse(output: URLSession.DataTaskPublisher.Output, url: URL) throws -> Data {
        guard let response = output.response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else {
            throw NetworkingError.badURLResponse(url: url)
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
