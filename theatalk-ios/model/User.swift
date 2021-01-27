//
//  User.swift
//  theatalk-ios
//
//  Created by riku iwasaki on 2020/12/16.
//

import Foundation
import SwiftUI
struct User:Hashable,Codable{
    var name: String
    var tags: [Int]
    private var image_name: String
    var image: Image{
        Image(image_name)
    }
}
