//
//  RoomFetcher.swift
//  theatalk-ios
//
//  Created by riku iwasaki on 2021/01/13.
//

import Foundation


class RoomFetcher{
    private let urllink=""
    @Published var roomData: [Room]=[]
    init(){
        fetchRoomData()
    }
    func fetchRoomData(){
        URLSession.shared.dataTask(with: URL(string:urllink)!){ (data,response,error)in
            guard let data=data else{return}
            let decoder:JSONDecoder=JSONDecoder()
            do{
                //let searchResultData=try decoder.decode(RoomList.self, from: data)
                //DispatchQueue.main.async {
                  //  self.roomData=searchResultData.rooms.reversed()
               // }
            } catch{
                
            }
        }.resume()
    }
}
