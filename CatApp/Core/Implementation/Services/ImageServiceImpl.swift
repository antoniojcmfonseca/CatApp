//
//  ImageServiceImpl.swift
//  CatApp
//
//  Created by António Fonseca on 13/05/2024.
//

import Alamofire
import AlamofireImage

class ImageServiceImpl: ImageService {
    
    let networkManager: NetworkManager

        init(networkmanager: NetworkManager) {
            self.networkManager = networkmanager
        }

    
    func getImage(from url: String) async -> Image? {
        
        var image: Image?
        
        let imageCache = await networkManager.imageCache()
        
        if let image = imageCache.image(withIdentifier: url) {
            return image
        }
        
        image = await networkManager.downloadImage(from: url)
        
        if let image = image {
            imageCache.add(image, withIdentifier: url)
        }
        
        return image
    }
}
