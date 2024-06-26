//
//  MockNetworkManager.swift
//  CatApp
//
//  Created by António Fonseca on 12/05/2024.
//

import Foundation
import AlamofireImage

class MockNetworkManager: NetworkManager {
    
    var jsonData: Data?
    var shouldReturnError = false
    
    func getRequest<T>(path: String, parameters: [String : Any]?) async throws -> T where T : Decodable {
        
        if shouldReturnError {
            throw NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Mock error"])
        }
        
        guard let data = jsonData else { throw NSError(domain: "", code: 1, userInfo: [NSLocalizedDescriptionKey: "Mock error - no data found"]) }
        return try! JSONDecoder().decode(T.self, from: data)
    }
    
    func downloadImage(from url: String) async -> Image? {

            if shouldReturnError {
                return nil
            }

            return Image(systemName: "photo")
        }

        func imageCache() async -> AutoPurgingImageCache {
            await MainActor.run {
                return AutoPurgingImageCache()
            }
        }
}
