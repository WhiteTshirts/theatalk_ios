//
//  Environment.swift
//  theatalk-ios
//
//  Created by riku iwasaki on 2021/04/12.
//

import SwiftUI
struct HostNameEnvironment: EnvironmentKey{
    typealias Value = String
    #if DEBUG
        static var defaultValue: String = "localhost"
    #else
        static var defaultValue: String = "www.theatalk.work"
    #endif

    
}
struct PortEnvironment: EnvironmentKey{
    typealias  Value = Int
    #if DEBUG
        static var defaultValue: Int = 5000
    #else
        static var defaultValue: Int = 443
    #endif
}

struct SchemeEnvironment: EnvironmentKey{
    typealias Value = String
    #if DEBUG
        static var defaultValue: String = "http"
    #else
        static var defaultValue: String = "https"

    #endif
}
struct WSSchemeEnvironment: EnvironmentKey{
    typealias Value = String
    #if DEBUG
        static var defaultValue: String = "ws"
    #else
        static var defaultValue: String = "wss"

    #endif
}
struct ApiPATHEnvironment: EnvironmentKey{
    typealias Value = String
    #if DEBUG
        static var defaultValue: String = "/api/v1"
    #else
        static var defaultValue: String = "/theatalk/api/v1"

    #endif
}
struct WebSocketPathEnvironment: EnvironmentKey{
    typealias Value = String
    #if DEBUG
        static var defaultValue: String = "/cable"
    #else
        static var defaultValue: String = "/theatalk/cable"

    #endif
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
    var WSSchemeEnvironment: String{
        get{
            return self[theatalk_ios.WSSchemeEnvironment.self]
        }
    }
    var ApiPathEnvironment: String{
        get{
            return self[theatalk_ios.ApiPATHEnvironment.self]
        }
    }
    var WebSocketPathEnvironment:String{
        get{
            return self[theatalk_ios.WebSocketPathEnvironment.self]
        }
    }
}

