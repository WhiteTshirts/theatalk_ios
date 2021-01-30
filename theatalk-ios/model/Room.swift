//
//  Room.swift
//  theatalk-ios
//
//  Created by riku iwasaki on 2020/12/16.
//

import Foundation
import SwiftUI
struct Room: Hashable, Identifiable {
    
    var name: String
    var id: Int
    var youtube_url: String
    var author: String
    var tags: [Int]
    var image_url: String
    var room_num: Int
    

}


