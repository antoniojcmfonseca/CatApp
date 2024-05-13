//
//  ImageServiceImpl.swift
//  CatApp
//
//  Created by António Fonseca on 13/05/2024.
//

import Alamofire
import AlamofireImage

class ImageServiceImpl: ImageService {
    
    func getImage(from url: String) -> UIImage? {
        
        var image: UIImage?
        
        AF.request(url).responseImage { respone in
            switch(respone.result) {
            case .success(let loadedImage):
                image = loadedImage
            case .failure(let error):
                print("Error loading image: \(error.localizedDescription)")
            }
        }
        
        return image
    }
}
