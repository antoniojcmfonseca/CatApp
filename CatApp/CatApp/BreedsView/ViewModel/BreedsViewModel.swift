//
//  BreedsViewModel.swift
//  CatApp
//
//  Created by António Fonseca on 13/05/2024.
//

import Foundation
import SwiftData

class BreedsViewModel: ObservableObject {
    
    @Published var breeds: [BreedViewModel] = []
    @Published var searchText: String = ""
    
    private var breedService: BreedService
    private var imageService: ImageService
    private var context: ModelContext
    
    private var favoriteBreeds: [FavoriteBreed] = []
    
    init(breedService: BreedService, imageService: ImageService, context: ModelContext) {
        
        self.breedService = breedService
        self.imageService = imageService
        self.context = context
        
        fetchFavoriteBreeds()
    }
    
    var filteredBreeds: [BreedViewModel] {
        if searchText.isEmpty {
            return breeds
        } else {
            return breeds.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
    }
    
    func loadBreeds() {
        
        Task {
            
            var listOfBreeds: [Breed] = []
            
            do {
                listOfBreeds = try await breedService.getBreeds()
            } catch let error {
                print(error)
            }
            
            var breedViewModel: [BreedViewModel] = []
            
            for breed in listOfBreeds {
                breedViewModel.append(BreedViewModel(breed: breed, imageService: imageService))
            }
            
            let matchingBreeds = matchFavorites(breeds: breedViewModel)
            
            await MainActor.run {
                breeds = matchingBreeds
            }
        }
    }
}

// MARK: Favorites
extension BreedsViewModel {
    
    func addFavorite(breed: BreedViewModel) {
        
        breed.setFavorite(state: true)
        
        let favorite = FavoriteBreed(id: breed.id, name: breed.name, origin: breed.origin, temperament: breed.temperament, breedDescription: breed.description, lifeSpan: breed.lifeSpan, url: breed.url)
        context.insert(favorite)
        saveContext()
        fetchFavoriteBreeds()
    }
    
    func removeFavorite(breed: BreedViewModel) {
        
        breed.setFavorite(state: false)
        
        if let favorite = favoriteBreeds.first(where: { $0.id == breed.id }) {
            
            context.delete(favorite)
            saveContext()
            fetchFavoriteBreeds()
        }
    }
    
    private func saveContext() {
        
        do {
            try context.save()
        } catch {
            print("Failed to save context: \(error.localizedDescription)")
        }
    }
    
    private func fetchFavoriteBreeds() {
        
        let fetchDescriptor = FetchDescriptor<FavoriteBreed>()
        
        do {
            favoriteBreeds = try context.fetch(fetchDescriptor)
        } catch {
            print("Failed to fetch favorite breeds: \(error.localizedDescription)")
        }
    }
    
    private func matchFavorites(breeds: [BreedViewModel]) -> [BreedViewModel] {
        
        let matchingFavoritesBreeds: [BreedViewModel] = breeds
        
        for breed in matchingFavoritesBreeds {
            breed.setFavorite(state: favoriteBreeds.contains(where: { $0.id == breed.id }))
        }
        
        return matchingFavoritesBreeds
    }
}
