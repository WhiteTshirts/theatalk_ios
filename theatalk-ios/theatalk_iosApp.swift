//
//  theatalk_iosApp.swift
//  theatalk-ios
//
//  Created by riku iwasaki on 2020/12/16.
//

import SwiftUI
import UIKit
//global value
extension UIScreen{

   static let screenWidth = UIScreen.main.bounds.size.width
   static let screenHeight = UIScreen.main.bounds.size.height
   static let screenSize = UIScreen.main.bounds.size
}
var ProfileSize = CGSize(width: min(UIScreen.screenWidth/10,30), height: min(UIScreen.screenWidth/10,30))
var RoomSize_Column2=CGSize(width: UIScreen.screenWidth/2.2, height: UIScreen.screenHeight/5)
var RoomSize_Column1=CGSize(width: UIScreen.screenWidth/1.3, height: UIScreen.screenHeight/3)

var g_user_token = ""
struct ActivityIndicator: UIViewRepresentable {
    typealias UIViewType = UIActivityIndicatorView

    @Binding var isAnimating: Bool
    let style: UIActivityIndicatorView.Style

    func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> ActivityIndicator.UIViewType {
        UIActivityIndicatorView(style: style)
    }

    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }
}
//global value
@main
struct theatalk_iosApp: App {

    var body: some Scene {
        WindowGroup {
            InitialView().environmentObject(Session(login: false, user: nil))
        }
    }
}
