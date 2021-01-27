//
//  ModelData.swift
//  theatalk-ios
//
//  Created by riku iwasaki on 2021/01/13.
//

import Foundation
import Combine
var a=[1]


var mockRoomsData:[Room]
    = [Room(name:"test1",id:0,youtube_url:"https://www.youtube.com/watch?v=FIkhzBJAcTM&ab_channel=HikakinGames",author:"user1",tags:a,image_url:"img_name"),
       Room(name:"test2",id:1,youtube_url:"https://www.youtube.com/watch?v=5dVcn8NjbwY&ab_channel=TED",author:"user2",tags:a,image_url:"img_name2"),
       Room(name:"test2",id:2,youtube_url:"https://www.youtube.com/watch?v=5dVcn8NjbwY&ab_channel=TED",author:"user2",tags:a,image_url:"img_name2"),
       Room(name:"test3",id:3,youtube_url:"https://www.youtube.com/watch?v=5dVcn8NjbwY&ab_channel=TED",author:"user2",tags:a,image_url:"img_name2"),
       Room(name:"test4",id:4,youtube_url:"https://www.youtube.com/watch?v=5dVcn8NjbwY&ab_channel=TED",author:"user2",tags:a,image_url:"img_name2"),
    
       Room(name:"test5",id:5,youtube_url:"https://www.youtube.com/watch?v=5dVcn8NjbwY&ab_channel=TED",author:"user2",tags:a,image_url:"img_name2"),
    
       Room(name:"test6",id:6,youtube_url:"https://www.youtube.com/watch?v=5dVcn8NjbwY&ab_channel=TED",author:"user2",tags:a,image_url:"img_name2"),
       Room(name:"test7",id:7,youtube_url:"https://www.youtube.com/watch?v=5dVcn8NjbwY&ab_channel=TED",author:"user2",tags:a,image_url:"img_name2")]

final class ModelData: ObservableObject{
    @Published var rooms: [Room] = mockRoomsData
}

