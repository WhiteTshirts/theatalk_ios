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
    @State var RoomSize_Column1=CGSize(width: UIScreen.screenWidth/1.3, height: UIScreen.screenHeight/3)

    var body: some View {
        
        VStack{
            let url="http://img.youtube.com/vi/"+room.youtube_id+"/mqdefault.jpg"
            KFImage(URL(string:url))
                .placeholder {
                Image(systemName: "arrow.2.circlepath.circle")
                    .font(.largeTitle)
                    .opacity(0.3)
                    .frame(width: RoomSize_Column1.width,height: RoomSize_Column1.height)
                    
            }.frame(width:RoomSize_Column1.width)
            HStack(alignment: .top){
                Text(room.name)
                    .font(.caption)
                    .foregroundColor(Color.black)
                Text("参加人数\(room.viewer)人")
                    .font(.caption)
                    .foregroundColor(Color.black)
            }
        }
        
    }
}

//struct RoomCell_Previews: PreviewProvider {
//    static var previews: some View {
//        RoomCell(room: ModelData().rooms[0])
//
//    }
//}
