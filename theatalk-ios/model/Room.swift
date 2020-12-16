//
//  Room.swift
//  theatalk-ios
//
//  Created by riku iwasaki on 2020/12/16.
//

import Foundation
import SwiftUI
struct Room:Hashable,Codable{
    var name: String
    var num: Int
    var youtube_url: String
    var author: String
    var tags: [Int]
    
    private var image_name: String
    var image: Image{
        Image(image_name)
    }
}
