//
//  BreedsViewModel.swift
//  CatApp
//
//  Created by António Fonseca on 13/05/2024.
//

import Foundation

class BreedsViewModel: ObservableObject {
    
    @Published var breeds: [BreedViewModel] = []
    @Published var searchText: String = ""
    @Published var isLoading: Bool = false
    
    private var breedService: BreedService
    private var imageService: ImageService
    
    private var currentPage = 0
    private var canLoadMorePages = true
    
    init(breedService: BreedService, imageService: ImageService) {
        self.breedService = breedService
        self.imageService = imageService
    }
    
    var filteredBreeds: [BreedViewModel] {
        if searchText.isEmpty {
            return breeds
        } else {
            return breeds.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
    }
    
    func loadBreeds(page: Int = 0) {
        
        guard !isLoading else {
            return
        }
        
        isLoading = true
        
        Task {
            
            var listOfBreeds: [Breed] = []
            
            do {
                listOfBreeds = try await breedService.getBreeds(limit: 10, page: currentPage)
                
                self.currentPage = page
                self.canLoadMorePages = !listOfBreeds.isEmpty
                self.isLoading = false
            } catch let error {
                print(error)
                self.isLoading = false
            }
            
            var breedViewModel: [BreedViewModel] = []
            
            for breed in listOfBreeds {
                breedViewModel.append(BreedViewModel(breed: breed, imageService: imageService))
            }
            
            let breedVM = breedViewModel
            
            await MainActor.run {
                breeds.append(contentsOf: breedVM)
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
