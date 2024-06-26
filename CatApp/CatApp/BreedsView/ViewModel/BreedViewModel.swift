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
    @Published var favorite: Bool
    
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
    
    init (favoriteBreed: FavoriteBreed, imageService: ImageService) {
        self.id = favoriteBreed.id
        self.name = favoriteBreed.name
        self.origin = favoriteBreed.origin
        self.temperament = favoriteBreed.temperament
        self.description = favoriteBreed.breedDescription
        self.lifeSpan = favoriteBreed.lifeSpan
        self.url = favoriteBreed.url
        self.favorite = true
        
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
    
    func setFavorite(state: Bool) {
        favorite = state
    }
    
    var higherAge: Int? {
        let components = lifeSpan.split(separator: "-").map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
        
        if let lastComponent = components.last, let higherAge = Int(lastComponent) {
            return higherAge
        } else if let firstComponent = components.first, let lowerAge = Int(firstComponent) {
            return lowerAge
        }
        
        return nil
    }
}

extension BreedViewModel: Hashable {
    
    static func == (lhs: BreedViewModel, rhs: BreedViewModel) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        return hasher.combine(id)
    }
    
}

