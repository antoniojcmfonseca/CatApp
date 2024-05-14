//
//  BreedCellView.swift
//  CatApp
//
//  Created by António Fonseca on 14/05/2024.
//

import SwiftUI

struct BreedCellView: View {
    
    @ObservedObject var viewModel: BreedViewModel
    @State(initialValue: Image("placeholder")) var image: Image
    
    var body: some View {
        VStack {
            image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 160, height: 200)
                .clipped()
            
            HStack {
                Text(viewModel.name)
                    .font(.caption)
                    .lineLimit(1)
                Spacer()
                Button(action: {
                    if viewModel.favorite {
                        //viewModel.removeFavorite(breed: breed)
                    } else {
                        //viewModel.addFavorite(breed: breed)
                    }
                }) {
                    Image(systemName: viewModel.favorite ? "heart.fill" : "heart")
                        .foregroundColor(viewModel.favorite ? .red : .gray)
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
            image = viewModel.image
        }
        .onChange(of: viewModel.image) { oldValue, newValue in
            image = newValue
        }
    }
}
