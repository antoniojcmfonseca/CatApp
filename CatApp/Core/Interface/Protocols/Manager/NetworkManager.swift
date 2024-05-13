//
//  NetworkManager.swift
//  CatApp
//
//  Created by António Fonseca on 12/05/2024.
//

import Foundation

protocol NetworkManager {
    func getRequest<T: Decodable>(path: String, parameters: [String: Any]?) async throws -> T
    //func postRequest<T: Decodable>(path: String, parameters: [String: Any]?) async throws -> T
}
