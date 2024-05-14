//
//  ImageService.swift
//  CatApp
//
//  Created by António Fonseca on 13/05/2024.
//

import AlamofireImage

protocol ImageService {
    
    func getImage(from url: String) async -> UIImage?
}
