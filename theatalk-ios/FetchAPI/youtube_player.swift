//
//  youtube_player.swift
//  theatalk-ios
//
//  Created by riku iwasaki on 2021/02/01.
//

import Foundation
import SwiftUI
//import UIKit
//import WebKit
import AVKit
import UIKit

import YoutubeKit
enum PlayerAction{
    case none
    case play
    case stop
}
struct PlayerView: UIViewRepresentable{
    @Binding var action:PlayerAction
    typealias UIViewType = YTSwiftyPlayer
    @Binding var videoId:String
    func makeUIView(context: Context) -> YTSwiftyPlayer {
        let player = YTSwiftyPlayer()
        player.autoplay = true
        return player
    }
    
    func updateUIView(_ uiView: YTSwiftyPlayer, context: Context) {
        uiView.setPlayerParameters([
            .playsInline(true),
            .videoID(videoId),
        ])
        uiView.loadPlayer()
        switch action {
        case .play:
            uiView.loadPlayer()
        case .stop:
            uiView.stopVideo()
        case .none:
            break
        }
        action = .none
        

    }
}


//
//class ViewController: UIViewController, WKUIDelegate {
//
//    var webView: WKWebView!
//
//    override func loadView() {
//        let webConfiguration = WKWebViewConfiguration()
//        webView = WKWebView(frame: .zero, configuration: webConfiguration)
//        webView.uiDelegate = self
//        view = webView
//    }
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        let myURL = URL(string:"https://www.apple.com")
//        let myRequest = URLRequest(url: myURL!)
//        webView.load(myRequest)
//    }
//
//}
