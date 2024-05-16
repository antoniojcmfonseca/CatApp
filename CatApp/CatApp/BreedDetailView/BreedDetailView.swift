//
//  BreedDetailView.swift
//  CatApp
//
//  Created by António Fonseca on 14/05/2024.
//

import SwiftUI

struct BreedDetailView: View {
    
    var viewModel: BreedsViewModel
    @ObservedObject var breedViewModel: BreedViewModel
    
    var body: some View {
        VStack {
            HStack {
                breedViewModel.image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 300)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .shadow(radius: 10)
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Origin: \(breedViewModel.origin)")
                    .font(.headline)
                Text("Temperament: \(breedViewModel.temperament)")
                    .font(.headline)
                Text("Description: \(breedViewModel.description)")
                    .font(.headline)
                Text("Lifespan: \(breedViewModel.lifeSpan)")
                    .font(.headline)
            }
            
            Spacer()
            
            Button(action: {
                if breedViewModel.favorite {
                    viewModel.removeFavorite(breed: breedViewModel)
                } else {
                    viewModel.addFavorite(breed: breedViewModel)
                }
            }) {
                Text(breedViewModel.favorite ? "Remove from Favorites" : "Add to Favorites")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(breedViewModel.favorite ? Color.red : Color.blue)
                    .cornerRadius(10)
            }
            .padding(.top)
            
            Spacer()
        }
        .padding()
        .navigationTitle(breedViewModel.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}
