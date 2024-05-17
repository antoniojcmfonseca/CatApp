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
    @Published var isLoading: Bool = false
    @Published var isOfflineMode: Bool = false
    
    private var breedService: BreedService
    private var imageService: ImageService
    private var context: ModelContext
    
    private var favoriteBreeds: [FavoriteBreed] = []
    
    private var currentPage = 0
    private var canLoadMorePages = true
    
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
    
    var filteredFavoriteBreeds: [BreedViewModel] {
        let favoriteBreedIDs = Set(favoriteBreeds.map { $0.id })
        return breeds.filter { favoriteBreedIDs.contains($0.id) }
    }
    
    var averageLifespan: Double {
        let lifespans = filteredFavoriteBreeds.compactMap { $0.higherAge }
        guard !lifespans.isEmpty else { return 0 }
        return Double(lifespans.reduce(0, +)) / Double(lifespans.count)
    }
    
    func loadBreeds(page: Int = 0) {
        
        guard !isLoading else {
            return
        }
        
        isLoading = true
        
        Task {
            
            var listOfBreeds: [Breed] = []
            
            var currentpage = self.currentPage
            var canLoadMorePages = self.canLoadMorePages
            var isLoading = self.isLoading
            var isOfflineMode = self.isOfflineMode
            
            do {
                listOfBreeds = try await breedService.getBreeds(limit: 10, page: currentPage)
                
                currentPage = page
                canLoadMorePages = !listOfBreeds.isEmpty
                isLoading = false
                isOfflineMode = self.breeds.isEmpty && listOfBreeds.isEmpty
            } catch let error {
                print(error)
                isLoading = false
                isOfflineMode = true
            }
            
            var breedViewModel: [BreedViewModel] = []
            
            for breed in listOfBreeds {
                breedViewModel.append(BreedViewModel(breed: breed, imageService: imageService))
            }
            
            for favoriteBreed in favoriteBreeds {
                breedViewModel.append(BreedViewModel(favoriteBreed: favoriteBreed, imageService: imageService))
            }
            
            let breedsVM = breedViewModel
            let newPage = currentpage
            let newLoadMorePages = canLoadMorePages
            let newLoadingState = isLoading
            let newOfflineModeState = isOfflineMode
            
            await MainActor.run {
                let matchingBreeds = matchFavorites(breeds: breedsVM)
                
                var updatedBreeds = breeds
                updatedBreeds.append(contentsOf: matchingBreeds)
                
                breeds = updatedBreeds.removingDuplicatesById()
                
                self.currentPage = newPage
                self.canLoadMorePages = newLoadMorePages
                self.isLoading = newLoadingState
                self.isOfflineMode = newOfflineModeState
                
            }
        }
    }
    
    func loadMoreBreedsIfNeeded(currentBreed: BreedViewModel) {
        
        guard let lastBreed = breeds.last else { return }
        
        if lastBreed.id == currentBreed.id && canLoadMorePages {
            loadBreeds(page: currentPage + 1)
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
            breeds = matchFavorites(breeds: breeds)
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
