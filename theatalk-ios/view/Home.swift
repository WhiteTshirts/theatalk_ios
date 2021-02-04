//
//  Home.swift
//  theatalk-ios
//
//  Created by riku iwasaki on 2020/12/16.
//

import SwiftUI
import UIKit

struct ActivityIndicator: UIViewRepresentable {
    typealias UIViewType = UIActivityIndicatorView

    @Binding var isAnimating: Bool
    let style: UIActivityIndicatorView.Style

    func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> ActivityIndicator.UIViewType {
        UIActivityIndicatorView(style: style)
    }

    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }
}
extension UIScreen{

   static let screenWidth = UIScreen.main.bounds.size.width
   static let screenHeight = UIScreen.main.bounds.size.height
   static let screenSize = UIScreen.main.bounds.size
}
struct Sidemenu: View{
    var body: some View{
        Text("aaaaaa")
    }
}
struct Home: View {
    @State var loading = true
    @State var info = false
    @ObservedObject var RoomsVM: RoomsViewModel
    @State var textEntered = ""
    @State var ProfileSize = CGSize(width: UIScreen.screenWidth/10, height: UIScreen.screenWidth/10)
    @State var RoomSize_Column2=CGSize(width: UIScreen.screenWidth/2.2, height: UIScreen.screenHeight/5)
    var body: some View {
        ZStack{
            NavigationView {
                ScrollView{
                    ForEach(RoomsVM.rooms){room in
                        HStack{
                            NavigationLink(
                                destination: ChatRoom(room:room)){
                                RoomCell(room: room)
                            }
                        }
                    }
                }.onAppear{
                    RoomsVM.load()
                }
                .navigationBarItems(leading:VStack{
                    HStack(alignment: .top){
                        Button(action: {
                            info = true
                        }){
                            Rectangle().fill().frame(width: ProfileSize.width,height: ProfileSize.height)
                        }
                    
                        TextField("検索",text:$textEntered)
                        NavigationLink("+",destination:CreateRoom())
                    }
                }
                .padding()
                )
            }
            if(info){
                Sidemenu()

            }

        }
    }

}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
                ForEach(["iPhone SE", "iPhone X"], id: \.self) { deviceName in
            Home(RoomsVM: .init())
                .previewDevice(PreviewDevice(rawValue: deviceName))
                .previewDisplayName(deviceName)
        }
    }
    
}
