//
//  theatalk_iosApp.swift
//  theatalk-ios
//
//  Created by riku iwasaki on 2020/12/16.
//

import SwiftUI

@main
struct theatalk_iosApp: App {
    var body: some Scene {
        WindowGroup {
            Home(RoomsVM: RoomsViewModel())
        }
    }
}
