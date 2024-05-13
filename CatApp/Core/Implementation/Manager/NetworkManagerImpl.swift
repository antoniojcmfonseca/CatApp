//
//  NetworkManagerImpl.swift
//  CatApp
//
//  Created by António Fonseca on 13/05/2024.
//

import Alamofire

class NetworkManagerImpl: NetworkManager {
    
    static let shared = NetworkManagerImpl()
    
    private let baseUrl = "https://api.thecatapi.com/"
    private let apiKey = "live_I02O9MMow6af2OG4RNhXHQLTQvOsIYGUwzh7lQe2XyEEy1aE6nzlvy7LQaaQLj1Y"
    
    init() {
        
    }
    
    func getRequest<T: Decodable>(path: String, parameters: [String: Any]?) async throws -> T {
        let url = baseUrl + path
        let headers: HTTPHeaders = ["x-api-key": apiKey]
        
        let request = AF.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: headers)
        return try await request.serializingDecodable(T.self).value
    }
    
    func postRequest<T: Decodable>(path: String, parameters: [String: Any]?) async throws -> T {
        let url = baseUrl + path
        let headers: HTTPHeaders = ["x-api-key": apiKey]
        
        let request = AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
        return try await request.serializingDecodable(T.self).value
    }
}
