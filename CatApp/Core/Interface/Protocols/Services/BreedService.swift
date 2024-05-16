//
//  BreedService.swift
//  CatApp
//
//  Created by António Fonseca on 13/05/2024.
//

import Foundation

protocol BreedService {
    
    func getBreeds(limit: Int, page: Int) async throws -> [Breed]
}
