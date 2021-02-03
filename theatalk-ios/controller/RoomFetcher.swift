//
//  RoomFetcher.swift
//  theatalk-ios
//
//  Created by riku iwasaki on 2021/01/13.
//

import Foundation


class RoomFetcher{
    private var urllink=""
    @Published var roomData: [Room]=[]
    init(url:String){
        urllink = url
    }
    func fetchRoomData(){
        let url:URL = URL(string: urllink)!
        let task: URLSessionTask = URLSession.shared.dataTask(with: url,completionHandler: {(data,response,error)in
            do{
                let roomData = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
                print(roomData)
            }catch{
                
            }

        })
        
        task.resume()
    }
}
