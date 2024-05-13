//
//  BreedsServiceImpl.swift
//  CatApp
//
//  Created by António Fonseca on 12/05/2024.
//

import Foundation

class BreedsServiceImpl: BreedService {
    
    let networkManager: NetworkManager
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func getBreeds() async throws -> [Breed] {
        let path = "v1/breeds"
        
        var breeds: [Breed] = []
        
        do {
            let breedResponse: [BreedResponse] = try await networkManager.getRequest(path: path, parameters: nil)
            breeds = breedResponse
        } catch let error {
            print("Error: \(error.localizedDescription)")
        }
        
        return breeds
    }
}
