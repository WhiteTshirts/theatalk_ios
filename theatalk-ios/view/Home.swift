//
//  Home.swift
//  theatalk-ios
//
//  Created by riku iwasaki on 2020/12/16.
//

import SwiftUI

extension UIScreen{

   static let screenWidth = UIScreen.main.bounds.size.width
   static let screenHeight = UIScreen.main.bounds.size.height
   static let screenSize = UIScreen.main.bounds.size
}
struct Home: View {
    @EnvironmentObject var roomData: ModelData

    @State var textEntered = ""
    @State var ProfileSize = CGSize(width: UIScreen.screenWidth/10, height: UIScreen.screenWidth/10)
    @State var RoomSize=CGSize(width: UIScreen.screenWidth/2.2, height: UIScreen.screenHeight/5)

    var body: some View {
        NavigationView {
            VStack(alignment: .center){
                Text("theatalk")
                    .foregroundColor(Color.red)
                HStack{
                    Rectangle().fill().frame(width: ProfileSize.width,height: ProfileSize.height)//写真
                    TextField("検索",text:$textEntered)
                    NavigationLink("+",destination:CreateRoom())
                            
                
                    
                }
                RoomList()

            }

    
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
