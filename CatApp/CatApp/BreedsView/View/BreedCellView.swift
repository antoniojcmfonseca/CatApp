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
            
            Spacer()
            
            breedViewModel.image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 150, height: 150)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .shadow(radius: 10)
            
            HStack {
                
                Spacer()
                
                Text(breedViewModel.name)
                    .foregroundStyle(.black)
                    .font(.caption)
                
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
                
                Spacer()
            }
            .padding(.top, 8)
            
            Spacer()
        }
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
        .frame(width: 180, height: 200)
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
