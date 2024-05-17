//
//  ImageServiceImpl.swift
//  CatApp
//
//  Created by António Fonseca on 13/05/2024.
//

import Alamofire
import AlamofireImage

class ImageServiceImpl: ImageService {
    
    func getImage(from url: String) async -> Image? {
        
        var image: Image?
        
        let imageCache = await ImageServiceImpl.imageCache()
        
        if let image = imageCache.image(withIdentifier: url) {
            return image
        }
        
        image = await downloadImage(from: url)
        
        if let image = image {
            imageCache.add(image, withIdentifier: url)
        }
        
        return image
    }
    
    private func downloadImage(from url: String) async -> Image? {
        
        await withCheckedContinuation { continuation in
            AF.request(url).responseImage { respone in
                switch(respone.result) {
                case .success(let loadedImage):
                    continuation.resume(returning: loadedImage)
                case .failure(let error):
                    print("Error loading image: \(error.localizedDescription)")
                    continuation.resume(returning: nil)
                }
            }
        }
    }
    
    private static func imageCache() async -> AutoPurgingImageCache {
        await MainActor.run {
            return AutoPurgingImageCache()
        }
    }
}
