//
//  BreedsView.swift
//  CatApp
//
//  Created by António Fonseca on 13/05/2024.
//

import SwiftUI

struct BreedsView: View {
    
    @ObservedObject let viewModel: BreedsViewModel
    
    var body: some View {
        NavigationView {
            List(viewModel.breeds) { breeds in
                    
            }
        }
    }
}
