//
//  BreedsView.swift
//  CatApp
//
//  Created by António Fonseca on 13/05/2024.
//

import SwiftUI

struct BreedsView: View {
    
    @ObservedObject var viewModel: BreedsViewModel
    
    let columns = [
        GridItem(.flexible(), spacing: 8),
        GridItem(.flexible(), spacing: 8)
    ]
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $viewModel.searchText)
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(viewModel.filteredBreeds) { breed in
                            NavigationLink(destination: BreedDetailView(viewModel: breed)) {
                                BreedCellView(viewModel: viewModel, breedViewModel: breed)
                            }
                        }
                    }
                    .padding()
                }
                .navigationTitle("Breeds")
                .onAppear {
                    viewModel.loadBreeds()
                }
            }
        }
    }
}
