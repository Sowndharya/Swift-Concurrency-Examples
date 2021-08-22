//
//  PhotosModel.swift
//  PhotosModel
//
//  Created by Sowndharya Maheswaran on 17/07/21.
//

import Foundation
import UIKit

let kThumbnailHeight = 100.0
let kThumbnailSize = CGSize(width: kThumbnailHeight, height: kThumbnailHeight)

class PhotosModel {
    
    lazy var photoItems: [PhotoItem] = {
        return PhotoItem.allCases
    }()
            
    var photosModelStore = PhotosModelStore()
    
    func fetchImage(at index: Int) async -> UIImage! {
        do {
            return try await self.photosModelStore.fetchImage(for: photoItems[index], with: kThumbnailSize)
        } catch {
            return nil
        }
    }
}
