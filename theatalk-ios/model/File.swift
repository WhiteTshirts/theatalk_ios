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
        case latitude
        case longitude
        case additionalInfo
    }
    
    enum AdditionalInfoKeys: String, CodingKey {
        case elevation
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
        try container.encode(latitude, forKey: .latitude)
        try container.encode(longitude, forKey: .longitude)
        
        var additionalInfo = container.nestedContainer(keyedBy: AdditionalInfoKeys.self, forKey: .additionalInfo)
        try additionalInfo.encode(elevation, forKey: .elevation)
    }
}
