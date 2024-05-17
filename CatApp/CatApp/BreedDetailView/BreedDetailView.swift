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
        
        ScrollView {
            
            if UIDevice.isIPad {
                
                HStack(alignment: .top, spacing: 16) {
                    
                    breedViewModel.image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 350, height: 350)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .shadow(color: Color.primary.opacity(0.2), radius: 10)
                        .padding()
                    
                    VStack(alignment: .leading) {
                        
                        Group {
                            SectionView(title: "Description", value: breedViewModel.description)
                            SectionView(title: "Origin", value: breedViewModel.origin)
                            SectionView(title: "Temperament", value: breedViewModel.temperament)
                            SectionView(title: "Lifespan", value: breedViewModel.lifeSpan)
                        }
                    }
                    .padding()
                }
            } else {
                
                VStack(alignment: .center, spacing: 16) {
                    
                    HStack {
                        
                        breedViewModel.image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 250, height: 250)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                            .shadow(color: Color.primary.opacity(0.2), radius: 10)
                            .padding()
                    }
                    
                    VStack(alignment: .leading) {
                        
                        Group {
                            SectionView(title: "Description", value: breedViewModel.description)
                            SectionView(title: "Origin", value: breedViewModel.origin)
                            SectionView(title: "Temperament", value: breedViewModel.temperament)
                            SectionView(title: "Lifespan", value: breedViewModel.lifeSpan)
                        }
                    }
                }
            }
        }
        .padding()
        .navigationTitle(breedViewModel.name)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    if breedViewModel.favorite {
                        viewModel.removeFavorite(breed: breedViewModel)
                    } else {
                        viewModel.addFavorite(breed: breedViewModel)
                    }
                }) {
                    Image(systemName: breedViewModel.favorite ? "heart.fill" : "heart")
                        .foregroundColor(breedViewModel.favorite ? .red : .blue)
                }
            }
        }
    }
}

struct SectionView: View {
    
    let title: String
    let value: String
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 4) {
            
            Text(title)
                .font(.headline)
                .foregroundColor(.primary)
            
            Text(value)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(.vertical, 4)
    }
}
