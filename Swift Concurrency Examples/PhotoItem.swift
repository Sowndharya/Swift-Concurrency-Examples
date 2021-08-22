//
//  Photos.swift
//  Photos
//
//  Created by Sowndharya Maheswaran on 22/08/21.
//

import Foundation
import UIKit

enum PhotoItem: String, CaseIterable {
    case nasa
    case deer
    case love
    case hood
    case alone
    case head
    case boat
    case canyon
    case path
    case sky
    case berry
    case light
    case girl
    case shoes
    case dream
    
    var id: String {
        switch self {
        case .nasa: return "1002"
        case .deer: return "1003"
        case .love: return "1004"
        case .hood: return "1005"
        case .alone: return "1006"
        case .head: return "1009"
        case .boat: return "1011"
        case .canyon: return "1015"
        case .path: return "1018"
        case .sky: return "1019"
        case .berry: return "102"
        case .light: return "1022"
        case .girl: return "1027"
        case .shoes: return "103"
        case .dream: return "104"
        }
    }
    
    var url: String {
        return "https://picsum.photos/id/" + self.id + "/\(Int(kThumbnailHeight))/\(Int(kThumbnailHeight))"
    }
    
    var name: String {
        return self.rawValue.uppercased()
    }
}
