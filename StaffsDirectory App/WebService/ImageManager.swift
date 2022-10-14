//
//  ImageDownloader.swift
//  StaffsDirectory
//
//  Created by Hafiz on 12/10/22.
//

import Foundation
import UIKit

class ImageManager: ImageDownLoader {

    let serviceManager: Servicable
    init(serviceManager: Servicable = ServiceManager()) {
        self.serviceManager = serviceManager
    }

    func getImage(url: String, completion:@escaping (Data) -> Void) {
        
        let imageCacher = ImageCacher.shared
        
        if let image = imageCacher.getImage(url: url) {
            completion(image)
        }else {
            serviceManager.get(url: url) { imageData in
                guard let imageData = imageData else {return}
                imageCacher.saveImage(url: url, data:imageData )
                completion(imageData)
            }
        }
    }
}

