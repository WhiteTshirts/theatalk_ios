//
//  ModelData.swift
//  theatalk-ios
//
//  Created by riku iwasaki on 2021/01/13.
//

import Foundation
import Combine

final class ModelData: ObservableObject{
    var rooms:[Room] = [];
}

var a=[1];


let mockRoomsData: [Room]
    = [Room(name:"test1",num:0,youtube_url:"https://www.youtube.com/watch?v=FIkhzBJAcTM&ab_channel=HikakinGames",author:"user1",tags:a,image_url:"img_name"),
       Room(name:"test2",num:1,youtube_url:"https://www.youtube.com/watch?v=5dVcn8NjbwY&ab_channel=TED",author:"user2",tags:a,image_url:"img_name2"),
       Room(name:"test2",num:1,youtube_url:"https://www.youtube.com/watch?v=5dVcn8NjbwY&ab_channel=TED",author:"user2",tags:a,image_url:"img_name2"),
       Room(name:"test3",num:1,youtube_url:"https://www.youtube.com/watch?v=5dVcn8NjbwY&ab_channel=TED",author:"user2",tags:a,image_url:"img_name2"),
       Room(name:"test4",num:1,youtube_url:"https://www.youtube.com/watch?v=5dVcn8NjbwY&ab_channel=TED",author:"user2",tags:a,image_url:"img_name2"),
    
       Room(name:"test5",num:1,youtube_url:"https://www.youtube.com/watch?v=5dVcn8NjbwY&ab_channel=TED",author:"user2",tags:a,image_url:"img_name2"),
    
       Room(name:"test6",num:1,youtube_url:"https://www.youtube.com/watch?v=5dVcn8NjbwY&ab_channel=TED",author:"user2",tags:a,image_url:"img_name2"),
       Room(name:"test7",num:1,youtube_url:"https://www.youtube.com/watch?v=5dVcn8NjbwY&ab_channel=TED",author:"user2",tags:a,image_url:"img_name2")]
