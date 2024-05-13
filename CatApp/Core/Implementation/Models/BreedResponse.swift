//
//  BreedResponse.swift
//  CatApp
//
//  Created by António Fonseca on 13/05/2024.
//

import Foundation

struct BreedResponse: Breed, Decodable {
    let id: String
    let name: String
    let origin: String
    let temperament: String
    let description: String
    let lifeSpan: String
    var image: BreedImage?
    
    private let imageResponse: BreedImageResponse
    
    enum CodingKeys: String, CodingKey {
        case id, name, origin, temperament, description
        case lifeSpan = "life_span"
        case imageResponse = "image"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        origin = try container.decode(String.self, forKey: .origin)
        temperament = try container.decode(String.self, forKey: .temperament)
        description = try container.decode(String.self, forKey: .description)
        lifeSpan = try container.decode(String.self, forKey: .lifeSpan)
        imageResponse = try container.decodeIfPresent(BreedImageResponse.self, forKey: .imageResponse) ?? BreedImageResponse(url: nil)
        image = imageResponse
    }
}
