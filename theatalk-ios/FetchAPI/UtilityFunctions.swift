//
//  UtilityFunctions.swift
//  theatalk-ios
//
//  Created by riku iwasaki on 2021/02/14.
//

import Foundation
import SwiftUI
extension String {}


func ParseYoutubeurl(url:String)->String?{
    let pattern = "^(?:https?://)?(www.)?(youtube.com|youtu.be)/(watch\\?v=|embed/|watch\\?.+&v=|v/)?(([A-Za-z0-9]|-|_){11})"
    //https://www.youtube.com/watch?v=LjkDJHk2KrE&ab_channel=YuNi-officialchannel- ->LjkDJHk2KrE
    var youtube_id:String?
    guard let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive)else{
        return nil
    }
    var results: [String] = []
    
    let matches = regex.matches(in: url, options: [], range: NSMakeRange(0, url.count))
    if(matches.count>0){
        matches.forEach{(match)-> () in
            results.append((url as NSString).substring(with: match.range(at: 4)) )
        }

        return results[0]
    }else{
        return nil
    }



    //if return value is nil, the url is invalid url.
    
    //^(?:https?://)?(www.)?(youtube.com|youtu.be)/(watch\?v=|embed/|watch\?.+&v=|v/)?[A-Za-z0-9]{11}?.*
//    https://www.youtube.com/watch?v=YxErrs4O12U
//    http://www.youtube.com/watch?v=YxErrs4O12U
//    youtube.com/watch?v=YxErrs4O12U
//    www.youtube.com/watch?v=YxErrs4O12U
//    https://youtu.be/jmfr36eqdRo
//    https://www.youtube.com/watch?v=jmfr36eqdRo&list=PLuO18pTvX5NIDP8pdNMnIL0uQWEage7JM
    
}
