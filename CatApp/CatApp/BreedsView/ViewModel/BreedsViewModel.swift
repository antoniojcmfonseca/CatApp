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
    
    private var breedService: BreedService
    private var imageService: ImageService
    
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
            
            let breedVM = breedViewModel
            
            await MainActor.run {
                breeds = breedVM
            }
        }
    }
}
