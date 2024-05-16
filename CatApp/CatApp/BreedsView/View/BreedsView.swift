//
//  BreedsView.swift
//  CatApp
//
//  Created by António Fonseca on 13/05/2024.
//

import SwiftUI

struct BreedsView: View {
    
    @StateObject var viewModel: BreedsViewModel
    
    let columns = [
        GridItem(.flexible(), spacing: 8),
        GridItem(.flexible(), spacing: 8)
    ]
    
    var body: some View {
        if viewModel.isOfflineMode {
            FavoriteBreedsView(viewModel: viewModel)
        } else {
            TabView {
                AllBreedsView(viewModel: viewModel)
                    .tabItem {
                        Label("All Breeds", systemImage: "list.bullet")
                    }
                
                FavoriteBreedsView(viewModel: viewModel)
                    .tabItem {
                        Label("Favorite Breeds", systemImage: "heart")
                    }
            }
        }
    }
}

struct AllBreedsView: View {
    @ObservedObject var viewModel: BreedsViewModel
    
    let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
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
    
    let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Average Lifespan: \(String(format: "%.1f", viewModel.averageLifespan)) years")
                                .font(.headline)
                                .padding()
                
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
                .navigationTitle("Favorite Breeds")
            }
        }
    }
}
