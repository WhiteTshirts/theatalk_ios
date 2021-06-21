//
//  ChatForm.swift
//  theatalk-ios
//
//  Created by riku iwasaki on 2021/06/22.
//

import SwiftUI
import Kingfisher

protocol RoomFormat{
    func ConfirmRoom()
    func isSucceeded()->Bool
    
}

struct RoomForm: View {
    @Binding var RoomName:String
    @Binding var Youtubelink:String
    @Binding var StartDate:Date
    @Binding var YoutubeId:String
    var roomFormat:RoomFormat!
    
    @ObservedObject var CrateRoomVM = CreateRoomViewModel()
    
    func ParseYoutubeId(){
        var youtube_id = ParseYoutubeurl(url: Youtubelink)
        if let youtube_id = ParseYoutubeurl(url: Youtubelink){
            self.YoutubeId = youtube_id
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
                roomFormat.ConfirmRoom()

            }, label: {
                Text("登録")
                    .fontWeight(.medium)
                    .frame(minWidth: 160)
                    .foregroundColor(.white)
                    .padding(12)
                    .background(Color.accentColor)
                    .cornerRadius(8)
            })
            if(roomFormat.isSucceeded()){
                

            }

            

        }
        .padding(.horizontal, 30.0)
        
    }
}
