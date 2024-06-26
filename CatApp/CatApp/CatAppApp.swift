//
//  CatAppApp.swift
//  CatApp
//
//  Created by António Fonseca on 12/05/2024.
//

import SwiftUI
import SwiftData

@main
struct CatAppApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            FavoriteBreed.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    var apiFactory: APIFactory = APIFactoryImpl()

    var body: some Scene {
        
        let breedsViewModel = BreedsViewModel(breedService: apiFactory.createBreedService(), imageService: apiFactory.createImageService(), context: sharedModelContainer.mainContext)
        
        WindowGroup {
            BreedsView(viewModel: breedsViewModel)
        }
        .modelContainer(sharedModelContainer)
    }
}
