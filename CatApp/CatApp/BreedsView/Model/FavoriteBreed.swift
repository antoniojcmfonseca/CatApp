//
//  FavoriteBreed.swift
//  CatApp
//
//  Created by António Fonseca on 16/05/2024.
//

import Foundation
import SwiftData

@Model
final class FavoriteBreed: Identifiable {
    let id: String
    let name: String
    let origin: String
    let temperament: String
    let breedDescription: String
    let lifeSpan: String
    let url: String?
    
    init(id: String, name: String, origin: String, temperament: String, breedDescription: String, lifeSpan: String, url: String?) {
        self.id = id
        self.name = name
        self.origin = origin
        self.temperament = temperament
        self.breedDescription = breedDescription
        self.lifeSpan = lifeSpan
        self.url = url
    }
}
