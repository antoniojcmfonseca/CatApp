//
//  NetworkManager.swift
//  CatApp
//
//  Created by António Fonseca on 12/05/2024.
//

import Foundation
import AlamofireImage

protocol NetworkManager {
    func getRequest<T: Decodable>(path: String, parameters: [String: Any]?) async throws -> T
    func downloadImage(from url: String) async -> Image?
    func imageCache() async -> AutoPurgingImageCache
}
