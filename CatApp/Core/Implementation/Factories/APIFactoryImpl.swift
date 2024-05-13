//
//  APIFactoryImpl.swift
//  CatApp
//
//  Created by António Fonseca on 13/05/2024.
//

import Foundation

class APIFactoryImpl: APIFactory {
    
    func createBreedService() -> BreedService {
        BreedsServiceImpl(networkManager: createNetworkManager())
    }
    
    private func createNetworkManager() -> NetworkManager {
        NetworkManagerImpl.shared
    }
}
