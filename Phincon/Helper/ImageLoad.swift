//
//  ImageLoad.swift
//  Phincon
//
//  Created by Sayyid Maulana Khakul Yakin on 28/10/21.
//

import UIKit

public extension UIImageView {
    func loadImage(using urlString: String) {
        let url = URL(string: urlString.addingPercentEncoding(
            withAllowedCharacters: CharacterSet.urlQueryAllowed)!)
        image = nil
        let cache = NSCache<NSString, UIImage>()
        if let img = cache.object(forKey: urlString as NSString) {
            image = img
        } else {
            guard let imageUrl = url else { return }
            DispatchQueue.global().async {
                URLSession.shared.dataTask(with: imageUrl, completionHandler: { (d, _, e) in
                    if e == nil {
                        DispatchQueue.main.async(execute: {
                            if let `data` = d, let img = UIImage(data: data) {
                                cache.setObject(img, forKey: urlString as NSString)
                                self.image = img
                            }
                        })
                    }
                })
                    .resume()
            }
        }
    }
    func changePngColorTo(color: UIColor){
        guard let image =  self.image else {return}
        self.image = image.withRenderingMode(.alwaysOriginal)
        self.tintColor = color
    }
}
