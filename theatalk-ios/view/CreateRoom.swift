//
//  CreateRoom.swift
//  theatalk-ios
//
//  Created by riku iwasaki on 2021/01/06.
//

import SwiftUI
import Kingfisher

struct RoomTagManageView: View{
    @State var room:Room
    var body: some View {
        Text("")
    }
}
struct CreateRoom: View {
    @State var RoomName:String=""
    @State var Youtubelink:String=""
    @State var StartDate = Date()
    @State var YoutubeId:String=""
    @ObservedObject var CrateRoomVM = CreateRoomViewModel()
    func ParseYoutubeId(){
        var youtube_id = ParseYoutubeurl(url: Youtubelink)
        if let youtube_id = ParseYoutubeurl(url: Youtubelink){
            self.YoutubeId = youtube_id
        }
    }
    func PostRoom(){
        var youtube_id = ParseYoutubeurl(url: Youtubelink)
        if let youtube_id = ParseYoutubeurl(url: Youtubelink){
            self.YoutubeId = youtube_id
            var room  = Room(name: RoomName, start_time: StartDate, youtube_id: youtube_id)
            CrateRoomVM.CreateRoom(room: room)
            
        }else{
            
        }
    }
    var body: some View {
        VStack{
            HStack{
                Text("Room名")
                TextField("hogehoge", text: self.$RoomName)

            }
            HStack{
                Text("Youtubeリンク")
                TextField("https://www.youtube.com/watch?v=jNQXAC9IVRw&ab_channel=jawed", text: self.$Youtubelink,onEditingChanged:{ begin in

                    ParseYoutubeId()
                })

            }
            if(YoutubeId != ""){
                HStack{
                    let url="http://img.youtube.com/vi/"+YoutubeId+"/mqdefault.jpg"
                    KFImage(URL(string:url))
                        .placeholder {
                        Image(systemName: "arrow.2.circlepath.circle")
                            .font(.largeTitle)
                            .opacity(0.3)
                            .frame(width: RoomSize_Column1.width,height: RoomSize_Column1.height)
                            .cornerRadius(5)
                            
                    }.onFailure { e in
                        }.frame(width:RoomSize_Column1.width)
                }
                
            }
            
            DatePicker("開始時刻",selection:$StartDate)
            Button(action: {
                PostRoom()

            }, label: {
                Text("登録")
                    .fontWeight(.medium)
                    .frame(minWidth: 160)
                    .foregroundColor(.white)
                    .padding(12)
                    .background(Color.accentColor)
                    .cornerRadius(8)
            })
            if(self.CrateRoomVM.isSuccessed){
                NavigationLink(
                    destination: MoveToChatRoom(room: self.CrateRoomVM.createdRoom),
                    isActive: self.$CrateRoomVM.isSuccessed,
                    label: {
                        EmptyView()
                    })
            }

            

        }
        .padding(.horizontal, 30.0)
        
    }
}

struct CreateRoom_Previews: PreviewProvider {
    static var previews: some View {
        CreateRoom()
    }
}
