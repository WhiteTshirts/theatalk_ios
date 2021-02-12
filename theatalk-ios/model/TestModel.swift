//
//  File.swift
//  theatalk-ios
//
//  Created by riku iwasaki on 2021/02/11.
//

import Foundation




struct Coordinate {
    var latitude: Double
    var longitude: Double
    var elevation: Double

    enum CodingKeys: String, CodingKey {

        
        case user
    }
    enum NestedKeys: String, CodingKey{
        case latitude
        case longitude
        case additionalInfo
    }
    
    init(){
        latitude = 0
        longitude = 0
        elevation = 1
    }
}

extension Coordinate: Encodable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        var nestObj = container.nestedContainer(keyedBy: NestedKeys.self, forKey: .user)
        try nestObj.encode(latitude, forKey: .latitude)
    }
}
