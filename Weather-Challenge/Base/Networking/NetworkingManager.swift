//
//  NetworkingManager.swift
//  Weather-Challenge
//
//  Created by Eric on 11/09/2023.
//

import Foundation

final class NetworkingManager {
    
    static let shared = NetworkingManager()
    
    private init() {}
    
    func request<T: Codable>(_ endpoint: Endpoint) async throws -> T {
        
        guard let url = endpoint.url else { throw NetworkingError.invalidUrl }
        
        let request = buildRequest(from: url, methodType: endpoint.methodType)
        
        print (request)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let response = response as? HTTPURLResponse,
              (200...300) ~= response.statusCode else {
            let statusCode = (response as! HTTPURLResponse).statusCode
            throw NetworkingError.invalidStatusCode(statusCode: statusCode)
        }
        
        
        let decoder = JSONDecoder()
        let decodedData = try decoder.decode(T.self, from: data)
        return decodedData
    }
}

extension NetworkingManager {
    enum NetworkingError: LocalizedError {
        case invalidUrl
        case invalidStatusCode(statusCode: Int)
        case invalidData
        case failedToDecode(error: Error)
        case custom(error: Error)
    }
}

extension NetworkingManager.NetworkingError {
    var errorDescription: String? {
        switch self {
        case .invalidUrl:
            return "There was an issue connecting the server. if this persiste, please contact support."
        case .invalidStatusCode(let statusCode):
            return "Invalid response from the server. Please try again later or contact support. \(statusCode)"
        case .invalidData:
            return "The data received from the server was invalid. Please contact support."
        case .failedToDecode:
            return "Failed to decode"
        case .custom(let error):
            return "\(error.localizedDescription) Please try again later or contact support."
        }
    }
}

private extension NetworkingManager {
    func buildRequest(from url: URL, methodType: Endpoint.MethodType) -> URLRequest {
        var request = URLRequest(url: url)
        
        switch methodType {
        case .GET:
            request.httpMethod = "GET"
        }
        return request
    }
}
