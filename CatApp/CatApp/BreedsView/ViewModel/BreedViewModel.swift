//
//  BreedViewModel.swift
//  CatApp
//
//  Created by António Fonseca on 13/05/2024.
//

import Foundation
import SwiftUI

class BreedViewModel: Identifiable, ObservableObject {
    let id: String
    let name: String
    let origin: String
    let temperament: String
    let description: String
    let lifeSpan: String
    let url: String?
    
    @Published var image: Image = Image("placeholder")
    var favorite: Bool
    
    private let imageService: ImageService
    
    init(breed: Breed, imageService: ImageService) {
        self.id = breed.id
        self.name = breed.name
        self.origin = breed.origin
        self.temperament = breed.temperament
        self.description = breed.description
        self.lifeSpan = breed.lifeSpan
        self.url = breed.image?.url
        
        self.favorite = false
        
        self.imageService = imageService
        
        loadImage()
    }
    
    func loadImage() {
        Task {
            guard let url = url, let uiImage = await imageService.getImage(from: url) else {
                return
            }
            
            await MainActor.run {
                self.image = Image(uiImage: uiImage)
            }
        }
    }
    
    func setFavoriteState() {
        favorite = !favorite
    }
}
