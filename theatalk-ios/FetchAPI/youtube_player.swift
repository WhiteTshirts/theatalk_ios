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
    case load
}
struct PlayerView: UIViewRepresentable{
    @Binding var action:PlayerAction
    typealias UIViewType = YTSwiftyPlayer
    @Binding var videoId:String
    static let player = YTSwiftyPlayer()
    
    
    @Binding var time_offset:Int
    func makeUIView(context: Context) -> YTSwiftyPlayer {
        PlayerView.player.autoplay = true
        PlayerView.player.setPlayerParameters([
            .playsInline(true),
            .registerStartTimeAt(time_offset),
            .videoID(videoId),
        ])
        PlayerView.player.loadPlayer()
        return PlayerView.player
        
    }
    
    
    func updateUIView(_ uiView: YTSwiftyPlayer, context: Context) {
        switch action {
        case .play:
            PlayerView.player.playVideo()
            break
        case .stop:
            PlayerView.player.stopVideo()
            PlayerView.player.autoplay = false
            break
        case .load:
            PlayerView.player.loadPlayer()
            break
            
        case .none:
            PlayerView.player.stopVideo()
            break
        }
    
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
