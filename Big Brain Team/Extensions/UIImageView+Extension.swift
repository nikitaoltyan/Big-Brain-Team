//
//  UIImageView+Extension.swift
//  Big Brain Team
//
//  Created by Никита Олтян on 10.10.2021.
//

import UIKit

let imageCache = NSCache<NSString, UIImage>()


extension UIImageView{
    func downloadImage(from imgURL: String!){
        if let cachedImage = imageCache.object(forKey: imgURL as NSString) {
            self.image = cachedImage
        } else {
            let url = URLRequest(url: URL(string: imgURL)!)
            
            let task = URLSession.shared.dataTask(with: url) {
                (data, response, error) in
                
                if error != nil {
                    print(error!)
                    return
                }
                imageCache.setObject(UIImage(data: data!)!, forKey: imgURL as NSString)
                DispatchQueue.main.async {
                    self.image = UIImage(data: data!)
                }
            }
            task.resume()
        }
    }
}
