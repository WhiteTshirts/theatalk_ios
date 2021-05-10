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

    func GetDiff() -> some View{
 
        if(room.start_time == nil){
            if(room.viewer > 0){
                return Text("上映中です")
            }else{
                return Text("上映時間が設定されていません")
            }
        }else{
            if(room.start_time > Date()){
                let cal = Calendar(identifier: .gregorian)
                let diffsec = cal.dateComponents([.second], from: Date(), to:room.start_time)
                let formatter = DateComponentsFormatter()
                formatter.unitsStyle = .abbreviated
                formatter.allowedUnits = [.day,.hour,.minute,.second]
                
                let PrintText = formatter.string(from:diffsec)!
                 return Text("\(PrintText)後に開始予定です")


            }else if(room.viewer > 0){
                return Text("上映中です")
            }
            return Text("誰もルーム内にはいません")
            
        }

        
    }

    var body: some View {
        VStack{
            let url="http://img.youtube.com/vi/"+room.youtube_id+"/mqdefault.jpg"
            KFImage(URL(string:url))
                .placeholder {
                Image(systemName: "arrow.2.circlepath.circle")
                    .font(.largeTitle)
                    .opacity(0.3)
                    .frame(width: UIScreen.screenWidth)
                    .cornerRadius(5)
                    
            }.onFailure { e in
                }.resizable()
                .frame(width:UIScreen.screenWidth)
                .overlay(
                    
                    
                    ZStack{
                        GetDiff()
                            .background(Color.white).opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
     
                })
            HStack(alignment: .bottom){
                Text(" "+room.name)
                    .font(.headline)
                    .foregroundColor(Color.black)
                Text("参加人数\(room.viewer)人")
                    .font(.headline)
                    .foregroundColor(Color.red)
                
                Text(room.youtube_id)

            }.background(Color.white).opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
  
        }
        
    }


}

struct RoomCell_Previews: PreviewProvider {
    static var previews: some View {
        RoomCell(room: Room(admin_id:0,name:"test1",id:0,is_private: false,start_time: Calendar.current.date(byAdding: .hour,value:0, to: Date()), viewer: 1,youtube_id:"kgeG9kXFb0A"))

    }
}
