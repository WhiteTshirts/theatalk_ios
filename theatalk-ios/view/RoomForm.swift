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

struct RoomForm: View,TagManage {

    
    @Binding var RoomName:String
    @Binding var Youtubelink:String
    @Binding var StartDate:Date
    @Binding var YoutubeId:String
    @Binding var roomTags:[Tag]
    
    @ObservedObject var roomTagVM:RoomTagsViewModel
    var roomFormat:RoomFormat!
    
    @ObservedObject var RoomVM = RoomsViewModelBase()

    func DeleteTag(tag: Tag) {
        roomTagVM.RemoveTagFromRoom(tag: tag)

    }
    
    func AddTag(tag: Tag) {
        roomTagVM.AddTagToRoom(tag: tag)

    }

    private func GetTags(tags:[Tag],isRoomTag:Bool,color:Color) ->some View{
        var width = CGFloat.zero
        var height = CGFloat.zero
        
        return ZStack(alignment: .topLeading) {
            ForEach(tags){ tag in
                TagItemView(for: tag, color: color, isAddedTag: isRoomTag, tagdelegate: self)
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
                self.roomTags = roomTagVM.RoomTags
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
