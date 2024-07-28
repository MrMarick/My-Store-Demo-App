//
//  DynamicImgImageView.swift
//  vomos
//
//  Created by Guestmac on 12/13/21.
//

import Foundation
import UIKit

let imageCache = NSCache<NSString, UIImage>()

class DynamicImgImageView: UIImageView{
    
//    var imgUrl: String?
    
    func loadImage(urlString : String, placeholderImage: String){
        let imgUrl = urlString
        guard let url = URL(string: urlString) else {
            return
        }
        //Set initial image to nil so it doesn't use the image from a reused cell.
        //Set the placeholder image while image is loaded into the cell.
        self.image = UIImage(named: placeholderImage)
        //Check if the image is already in the cache.
        if let imageToCache = imageCache.object(forKey: urlString as NSString) {
            self.image = imageToCache
            return
        }
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
                guard let data = data, error == nil, let imageToCache = UIImage(data: data) else {
                    return
                }
                
                DispatchQueue.main.async {
                    if imgUrl == urlString {
                        self?.image = imageToCache
                    }
                    imageCache.setObject(imageToCache, forKey: urlString as NSString)
                }
            }.resume()
        }
    
}
