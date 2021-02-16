//
//  RoomCell.swift
//  theatalk-ios
//
//  Created by riku iwasaki on 2021/01/27.
//

import SwiftUI
import Kingfisher
struct RoomCell: View {


    var room: Room

    var body: some View {
        
        VStack{
            let url="http://img.youtube.com/vi/"+room.youtube_id+"/mqdefault.jpg"
            KFImage(URL(string:url))
                .placeholder {
                Image(systemName: "arrow.2.circlepath.circle")
                    .font(.largeTitle)
                    .opacity(0.3)
                    .frame(width: RoomSize_Column1.width,height: RoomSize_Column1.height)
                    .cornerRadius(5)
                    
            }.onFailure { e in
                }.frame(width:RoomSize_Column1.width)
                .overlay(
                    ZStack{
                        
                        HStack(alignment: .bottom){
                            Text(" "+room.name)
                                .font(.headline)
                                .foregroundColor(Color.black)
                            Text("参加人数\(room.viewer)人")
                                .font(.headline)
                                .foregroundColor(Color.red)
                        
                        }.background(Color.white).opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
                    }

                    ,alignment: .bottomTrailing
                    
                )
  
        }
        
    }


}

//struct RoomCell_Previews: PreviewProvider {
//    static var previews: some View {
//        RoomCell(room: Room(admin_id_:0,name_:"test1",id_:0,is_private_: false,start_time_: Date(), viewer_: 3,youtube_id_:"kgeG9kXFb0A"))
//
//    }
//}
