//
//  Avater.swift
//  theatalk-ios
//
//  Created by riku iwasaki on 2021/06/16.
//

import Foundation
import SwiftUI
class Avater:Identifiable,Codable{
    var imageString: String!
    var id: Int //user_id
    var image:Image{
        if (imageString != nil) {
            if let data = Data(base64Encoded: imageString),let uiImage = UIImage(data:data){
                return Image(uiImage: uiImage)
            }else{
                return Image ("default")
            }
        }else{
            return Image("default")
        }

    }
    enum DecodingKeys: CodingKey{
        case id,image
    }
    enum EncodeKeys:CodingKey{
        case id
    }
    enum EncodeRootKeys:CodingKey{
        case avater
    }
    init(imageString: String,id: Int){
        self.imageString = imageString
        self.id = id
    }
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DecodingKeys.self)
        imageString = try container.decode(String.self, forKey: .image)
        id = try container.decode(Int.self, forKey: .id)
    }
}

class Avater_Json:Codable{
    var avater:Avater!
}

class Avaters_Json:Codable{
    var avaters:[Avater]!
}
