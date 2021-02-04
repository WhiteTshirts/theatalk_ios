//
//  Home.swift
//  theatalk-ios
//
//  Created by riku iwasaki on 2020/12/16.
//

import SwiftUI


struct Sidemenu: View{
    @Binding var info: Bool
    var body: some View{
        VStack(alignment: .center){
            Button(action: {
                info = !info
            }){
                Image(systemName: "list.dash").resizable()
                .frame(width: ProfileSize.width,height: ProfileSize.height)
            }
            HStack {
                Image(systemName: "person")
                Text("Profile")
            }
            HStack {
                Image(systemName: "text.bubble")
                Text("Tags")
            }
            Spacer()
        }
        
    }
}
struct NavItem: View{
    @Binding var info: Bool
    @Binding var textEntered: String
    var body: some View{
        HStack(alignment: .top){
            Button(action: {
                info = !info
            }){
                Image(systemName: "list.dash").resizable()
                .frame(width: ProfileSize.width,height: ProfileSize.height)
            }
            TextField("検索",text:$textEntered)
            NavigationLink("+",destination:CreateRoom())
        }
        
    }
}

struct Home: View {
    @State var loading = true
    @ObservedObject var RoomsVM: RoomsViewModel
    @State var textEntered = ""
    @State var info = false
    @State var authfetcher = AuthFetcher()
    var body: some View {
        GeometryReader{ geometry in
            
            ZStack(alignment:.leading){
                NavigationView {
                    VStack{
                        HStack{
                            ScrollView{
                                RoomList(rooms: RoomsVM.rooms)
                            }.onAppear{
                                RoomsVM.load()
                            }
                            
                        }
                    }
                    .navigationBarItems(leading:VStack{
                        NavItem(info: self.$info, textEntered: self.$textEntered)
                    })

                }
                if info {
                    Sidemenu(info: self.$info)
                        .frame(width:UIScreen.screenWidth/2,height: UIScreen.screenHeight,alignment: .leading)
                        .background(Color.white)
                        .animation(.default)
                        .opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)

                        

                }


            }.gesture(DragGesture(minimumDistance: 5)
                        .onChanged{_ in
                            
                        }
                        .onEnded{ _ in
                            
                            
                        })
        }.onAppear{
            authfetcher.login(name: "hoge", password: "hoge")
        }

    }

}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
                ForEach(["iPhone SE", "iPhone X"], id: \.self) { deviceName in
                    Home(RoomsVM: RoomsViewModel())
                .previewDevice(PreviewDevice(rawValue: deviceName))
                .previewDisplayName(deviceName)
        }
    }
    
}
