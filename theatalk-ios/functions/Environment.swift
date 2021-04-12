//
//  Environment.swift
//  theatalk-ios
//
//  Created by riku iwasaki on 2021/04/12.
//

import SwiftUI
struct HostNameEnvironment: EnvironmentKey{
    typealias Value = String
    
    static var defaultValue: String = "localhost"
    
}
struct PortEnvironment: EnvironmentKey{
    typealias  Value = Int
    static var defaultValue: Int = 5000
}

struct SchemeEnvironment: EnvironmentKey{
    typealias Value = String
    static var defaultValue: String = "http"
}
extension EnvironmentValues{
    var HostNameEnvironment: String{
        get{
            return self[theatalk_ios.HostNameEnvironment.self]
        }
    }
    var PortEnvironment: Int{
        get{
            return self[theatalk_ios.PortEnvironment.self]
        }
    }
    var SchemeEnvironment: String{
        get{
            return self[theatalk_ios.SchemeEnvironment.self]
        }
    }
}

