//
//  BreedsView.swift
//  CatApp
//
//  Created by António Fonseca on 13/05/2024.
//

import SwiftUI

struct BreedsView: View {
    
    @StateObject var viewModel: BreedsViewModel
    
    var body: some View {
        NavigationView {
            if viewModel.isOfflineMode {
                FavoriteBreedsView(viewModel: viewModel, columns: gridColumns(isIPad: UIDevice.isIPad))
            } else {
                TabView {
                    AllBreedsView(viewModel: viewModel, columns: gridColumns(isIPad: UIDevice.isIPad))
                        .tabItem {
                            Label("All Breeds", systemImage: "list.bullet")
                        }
                    
                    FavoriteBreedsView(viewModel: viewModel, columns: gridColumns(isIPad: UIDevice.isIPad))
                        .tabItem {
                            Label("Favorites", systemImage: "heart")
                        }
                }
                .navigationViewStyle(StackNavigationViewStyle())
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    public func gridColumns(isIPad: Bool) -> [GridItem] {
        return Array(repeating: GridItem(.flexible(), spacing: 16), count: isIPad ? 3 : 2)
    }
}

struct AllBreedsView: View {
    
    @ObservedObject var viewModel: BreedsViewModel
    let columns: [GridItem]
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $viewModel.searchText)
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(viewModel.filteredBreeds) { breed in
                            NavigationLink(destination: BreedDetailView(viewModel: viewModel, breedViewModel: breed)) {
                                BreedCellView(viewModel: viewModel, breedViewModel: breed)
                                    .onAppear {
                                        viewModel.loadMoreBreedsIfNeeded(currentBreed: breed)
                                    }
                            }
                        }
                    }
                    .padding()
                }
                .navigationTitle("All Breeds")
                .onAppear {
                    viewModel.loadBreeds()
                }
            }
        }
    }
}

struct FavoriteBreedsView: View {
    
    @ObservedObject var viewModel: BreedsViewModel
    let columns: [GridItem]
    
    var body: some View {
        NavigationView {
            VStack {
                
                var textLabel = ""
                
                if viewModel.filteredFavoriteBreeds.isEmpty {
                    Text("No favorite breeds set")
                        .font(.headline)
                        .padding()
                } else if viewModel.averageLifespan > 0 {
                    Text("Average Lifespan: \(String(format: "%.1f", viewModel.averageLifespan)) years")
                        .font(.headline)
                        .padding()
                }
                
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(viewModel.filteredFavoriteBreeds) { breed in
                            NavigationLink(destination: BreedDetailView(viewModel: viewModel, breedViewModel: breed)) {
                                BreedCellView(viewModel: viewModel, breedViewModel: breed)
                            }
                        }
                    }
                    .padding()
                }
                .navigationTitle("Favorites")
            }
        }
    }
}
