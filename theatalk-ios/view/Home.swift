//
//  Home.swift
//  theatalk-ios
//
//  Created by riku iwasaki on 2020/12/16.
//

import SwiftUI
import Kingfisher

extension UIScreen{

   static let screenWidth = UIScreen.main.bounds.size.width
   static let screenHeight = UIScreen.main.bounds.size.height
   static let screenSize = UIScreen.main.bounds.size
}
struct Home: View {
    @EnvironmentObject var roomData: ModelData

    @State var textEntered = ""
    @State var ProfileSize = CGSize(width: UIScreen.screenWidth/10, height: UIScreen.screenWidth/10)
    @State var RoomSize_Column2=CGSize(width: UIScreen.screenWidth/2.2, height: UIScreen.screenHeight/5)
    @State var RoomSize_Column1=CGSize(width: UIScreen.screenWidth/1.3, height: UIScreen.screenHeight/3)
    var body: some View {
        NavigationView {
            ScrollView{
                ForEach(roomData.rooms){room in
                    HStack{
                        NavigationLink(
                            destination: ChatRoom(room:room)){
                            VStack{
                                let url="http://img.youtube.com/vi/"+room.youtube_url+"/mqdefault.jpg"
                                KFImage(URL(string:url)).frame(width:RoomSize_Column1.width)
                                HStack(alignment: .top){
                                    Text(room.name)
                                        .font(.caption)
                                        .foregroundColor(Color.black)
                                    Text("参加人数\(room.room_num)人")
                                        .font(.caption)
                                        .foregroundColor(Color.black)
                                }
                            }
                        }
                    }
                }
            }
            .navigationBarItems(leading:VStack{
                HStack(alignment: .top){
                    Rectangle().fill().frame(width: ProfileSize.width,height: ProfileSize.height)//写真
                    TextField("検索",text:$textEntered)
                    NavigationLink("+",destination:CreateRoom())
                }
            }
            .padding()
            )
        }
    }

}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Home()
                .environmentObject(ModelData())
        }
    }
}
