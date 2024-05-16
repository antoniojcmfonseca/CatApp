//
//  BreedCellView.swift
//  CatApp
//
//  Created by António Fonseca on 14/05/2024.
//

import SwiftUI

struct BreedCellView: View {
    
    var viewModel: BreedsViewModel
    @ObservedObject var breedViewModel: BreedViewModel
    @State(initialValue: Image("placeholder")) var image: Image
    @State(initialValue: false) var favorite: Bool
    
    var body: some View {
        VStack {
            image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 160, height: 200)
                .clipped()
            
            HStack {
                Text(breedViewModel.name)
                    .font(.caption)
                    .lineLimit(1)
                Spacer()
                Button(action: {
                    if favorite {
                        viewModel.removeFavorite(breed: breedViewModel)
                    } else {
                        viewModel.addFavorite(breed: breedViewModel)
                    }
                }) {
                    Image(systemName: favorite ? "heart.fill" : "heart")
                        .foregroundColor(favorite ? .red : .gray)
                }
            }
            .padding(.horizontal, 4)
            .padding(.bottom, 4)
        }
        .background(Color.white)
        .cornerRadius(8)
        .shadow(radius: 5)
        .frame(width: 160, height: 260)  // Ensure the cell is square
        .onAppear {
            image = breedViewModel.image
            favorite = breedViewModel.favorite
        }
        .onChange(of: breedViewModel.image) { oldValue, newValue in
            image = newValue
        }
        .onChange(of: breedViewModel.favorite) { oldValue, newValue in
            favorite = newValue
        }
    }
}
