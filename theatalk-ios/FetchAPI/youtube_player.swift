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
import YoutubePlayer_in_WKWebView

struct YoutubePlayer : UIViewRepresentable{

    
    let videoID: String
    let start_time:Int
    var player = WKYTPlayerView()
    func makeUIView(context: UIViewRepresentableContext<YoutubePlayer>) -> WKYTPlayerView {
        
        return player
    }
    func updateUIView(_ uiView: WKYTPlayerView, context: UIViewRepresentableContext<YoutubePlayer>) {
        uiView.load(withVideoId: videoID,playerVars: ["playsinline":1,"autoplay":1,"start":start_time])
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
