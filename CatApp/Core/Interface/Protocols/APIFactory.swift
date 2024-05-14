//
//  APIFactory.swift
//  CatApp
//
//  Created by António Fonseca on 13/05/2024.
//

import Foundation

protocol APIFactory {
    
    func createBreedService() -> BreedService
    
    func createImageService() -> ImageService
}
