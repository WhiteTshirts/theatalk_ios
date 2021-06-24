//
//  AuthUtility.swift
//  theatalk-ios
//
//  Created by riku iwasaki on 2021/03/30.
//

import Foundation

//func logout() {
//    let profile = UserProfile()
//    profile.token = ""
//    profile.password = ""
//    profile.username = ""
//    profile.user_Id = -1
//    profile.token_invalid = true
//}

func ErrorHandling(e:APIError)->String{
    switch e{
        case .token(description: let description):
            return(description)
        case .client(description: let description):
            return(description)
        case .server(description: let description):
            return(description)
        case .network(description: let description):
            return(description)
        case .parsing(description: let description):
            return(description)
        case .encoding(description: let description):
            return (description)
        case .other(error: let _):
            return "server unreachable or other error happened"
    }
}
