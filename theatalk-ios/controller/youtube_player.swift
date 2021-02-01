//
//  youtube_player.swift
//  theatalk-ios
//
//  Created by riku iwasaki on 2021/02/01.
//

import Foundation
import SwiftUI
import AVKit
import YoutubePlayer_in_WKWebView

struct YoutubePlayer : UIViewRepresentable {
    
    let videoID: String
    
    func makeUIView(context: UIViewRepresentableContext<YoutubePlayer>) -> WKYTPlayerView {
        var player = WKYTPlayerView()
        
        return player
    }
    
    func updateUIView(_ uiView: WKYTPlayerView, context: UIViewRepresentableContext<YoutubePlayer>) {
        uiView.load(withVideoId: videoID)
    }
}
