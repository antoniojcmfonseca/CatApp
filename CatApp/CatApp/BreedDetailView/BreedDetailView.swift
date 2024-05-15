//
//  BreedDetailView.swift
//  CatApp
//
//  Created by António Fonseca on 14/05/2024.
//

import SwiftUI

struct BreedDetailView: View {
    
    var viewModel: BreedViewModel
    
    var body: some View {
        VStack {
            HStack {
                viewModel.image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 300)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .shadow(radius: 10)
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Origin: \(viewModel.origin)")
                    .font(.headline)
                Text("Temperament: \(viewModel.temperament)")
                    .font(.headline)
                Text("Description: \(viewModel.description)")
                    .font(.headline)
                Text("Lifespan: \(viewModel.lifeSpan)")
                    .font(.headline)
            }
            
            Spacer()
        }
        .padding()
        .navigationTitle(viewModel.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}
