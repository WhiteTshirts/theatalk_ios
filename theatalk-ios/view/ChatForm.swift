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
    
    @ObservedObject var roomTagVM:RoomTagsViewModel
    var roomFormat:RoomFormat!
    
    @ObservedObject var CrateRoomVM = CreateRoomViewModel()
    func TagItem(for text:String,color:Color) -> some View{
        Text(text)
            .padding(.all,5)
            .font(.footnote)
            .background(color)
            .foregroundColor(.white)
            .cornerRadius(3)
    }

    func TagItemView(for tag:Tag,color:Color,isRoomTag:Bool)->some View{
        return
            TagItem(for: tag.name,color: color)
                .padding(.all,8)
                .overlay(
                    Button(action: {
                        print(tag.id)
                        print(isRoomTag)
                        if(isRoomTag){
                            roomTagVM.RemoveTagFromRoom(tag: tag)
                        }else{
                            roomTagVM.AddTagToRoom(tag:tag)
                        }
                    }, label: {
                        Image(systemName:isRoomTag ? "minus.circle":"plus.circle")
                                .resizable()
                                .frame(width: 16,height: 16)
                    }),alignment: .topTrailing
                    
                )
    }
    private func GetTags(tags:[Tag],isRoomTag:Bool,color:Color) ->some View{
        var width = CGFloat.zero
        var height = CGFloat.zero
        
        return ZStack(alignment: .topLeading) {
            ForEach(tags){ tag in
                TagItemView(for: tag, color: color, isRoomTag: isRoomTag)
                    .alignmentGuide(.leading, computeValue: { d in
                      if abs(width - d.width) > 300 {
                        width = 0
                        height -= d.height
                      }
                      let result = width
                        if tag == tags.last {
                        width = 0
                      } else {
                        width -= d.width
                      }
                      return result
                    })
                    .alignmentGuide(.top, computeValue: { _ in
                      let result = height
                        if tag == tags.last {
                        height = 0
                      }
                      return result
                    })
            }
        }
      }
    func TagSearchField()-> some View{
        
        VStack{
            HStack{
                Text("タグ入力:")
                TextField("tag名", text: $roomTagVM.SearchText)
            }

            Text("全てのタグ")
            GetTags(tags: roomTagVM.tags,isRoomTag: false, color: Color.green)
            Text("登録中のタグ一覧")
            GetTags(tags: roomTagVM.RoomTags,isRoomTag: true ,color: Color.red)
        }.onAppear{
            self.roomTagVM.load()
        }
    }
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
            TagSearchField()
            if(roomFormat.isSucceeded()){
                

            }

            

        }
        .padding(.horizontal, 30.0)
        
    }
}
