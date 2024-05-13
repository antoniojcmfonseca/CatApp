//
//  BreedViewModel.swift
//  CatApp
//
//  Created by António Fonseca on 13/05/2024.
//

import Foundation
import SwiftUI

class BreedViewModel: Identifiable {
    let id: String
    let name: String
    let origin: String
    let temperament: String
    let description: String
    let lifeSpan: String
    let image: Image
    var favorite: Bool
    
    init(breed: Breed, imageService: ImageService) {
        self.id = breed.id
        self.name = breed.id
        self.origin = breed.origin
        self.temperament = breed.origin
        self.description = breed.description
        self.lifeSpan = breed.lifeSpan
        self.favorite = false
        
        
        guard let url = breed.image?.url, let uiImage = imageService.getImage(from: url) else {
            self.image = Image("placeholder")
            return
        }
        
        self.image = Image(uiImage: uiImage)
    }
    
    func setFavoriteState() {
        favorite = !favorite
    }
}
