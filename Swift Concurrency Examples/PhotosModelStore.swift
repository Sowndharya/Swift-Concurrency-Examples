//
//  PhotosDataHandler.swift
//  PhotosDataHandler
//
//  Created by Sowndharya Maheswaran on 22/08/21.
//

import Foundation
import UIKit

enum PhotosModelStoreError: Error {
    case ImageEmptyError
    case ImageResizeError
}

struct PhotosModelStore {
    
    let imageCache = NSCache<NSString, AnyObject>()
    
    func fetchImage(for item: PhotoItem, with size: CGSize) async throws -> UIImage {
        if let cachedImage = self.imageCache.object(forKey: item.url as NSString) as? UIImage {
            return cachedImage
        }
        let data = try await NetworkHandler.downloadFile(urlString: item.url)
        guard let image = UIImage(data: data) else {
            self.imageCache.removeObject(forKey: item.url as NSString)
            throw PhotosModelStoreError.ImageEmptyError
        }
        guard let image = await image.byPreparingThumbnail(ofSize: size) else {
            self.imageCache.removeObject(forKey: item.url as NSString)
            throw PhotosModelStoreError.ImageResizeError
        }
        self.imageCache.setObject(image, forKey: item.url as NSString)
        return image
    }
}
