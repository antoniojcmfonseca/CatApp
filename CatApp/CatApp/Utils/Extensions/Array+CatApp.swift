//
//  Array+CatApp.swift
//  CatApp
//
//  Created by António Fonseca on 16/05/2024.
//

import Foundation

extension Array where Element == BreedViewModel {
    func removingDuplicatesById() -> [BreedViewModel] {
        var seen = Set<String>()
        return self.reduce(into: [BreedViewModel]()) { result, breed in
            if seen.insert(breed.id).inserted {
                result.append(breed)
            }
        }
    }
}
