//
//  ModelData.swift
//  theatalk-ios
//
//  Created by riku iwasaki on 2021/01/13.
//

import Foundation
import Combine
var a=[1]
var room1 = Room(name_:"a",id_:0,youtube_url_:"https://www.youtube.com/watch?v=FIkhzBJAcTM&ab_channel=HikakinGames",author_:"user1",tags_:a,image_url_:"img_name",room_num_: 0)

var mockRoomsData:[Room] = [Room(name_:"test1",id_:0,youtube_url_:"https://www.youtube.com/watch?v=FIkhzBJAcTM&ab_channel=HikakinGames",author_:"user1",tags_:a,image_url_:"img_name",room_num_: 3),Room(name_:"test2",id_:0,youtube_url_:"https://www.youtube.com/watch?v=FIkhzBJAcTM&ab_channel=HikakinGames",author_:"user1",tags_:a,image_url_:"img_name",room_num_: 0),Room(name_:"test3",id_:0,youtube_url_:"https://www.youtube.com/watch?v=FIkhzBJAcTM&ab_channel=HikakinGames",author_:"user1",tags_:a,image_url_:"img_name",room_num_: 2),Room(name_:"test4",id_:0,youtube_url_:"https://www.youtube.com/watch?v=FIkhzBJAcTM&ab_channel=HikakinGames",author_:"user1",tags_:a,image_url_:"img_name",room_num_: 10),Room(name_:"test5",id_:0,youtube_url_:"https://www.youtube.com/watch?v=FIkhzBJAcTM&ab_channel=HikakinGames",author_:"user1",tags_:a,image_url_:"img_name",room_num_: 0),Room(name_:"test6",id_:0,youtube_url_:"https://www.youtube.com/watch?v=FIkhzBJAcTM&ab_channel=HikakinGames",author_:"user1",tags_:a,image_url_:"img_name",room_num_: 0),Room(name_:"test7",id_:0,youtube_url_:"https://www.youtube.com/watch?v=FIkhzBJAcTM&ab_channel=HikakinGames",author_:"user1",tags_:a,image_url_:"img_name",room_num_: 1)]

final class ModelData: ObservableObject{
    @Published var rooms: [Room] = mockRoomsData
}

