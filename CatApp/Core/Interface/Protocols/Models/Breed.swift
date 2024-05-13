//
//  Breed.swift
//  CatApp
//
//  Created by António Fonseca on 12/05/2024.
//

import Foundation

protocol Breed {
    var id: String { get }
    var name: String { get }
    var origin: String { get }
    var temperament: String { get }
    var description: String { get }
    var lifeSpan: String { get }
    var image: BreedImage? { get }
}
