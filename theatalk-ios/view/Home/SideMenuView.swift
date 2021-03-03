//
//  SideMenuView.swift
//  theatalk-ios
//
//  Created by riku iwasaki on 2021/03/03.
//

import SwiftUI


struct SidemenuView: View{
    @State private var showingAlert = false
    @Binding var info: Bool
    @Binding var pushed: Bool
    @Binding var SelectedMenu: String
    var sideDel: SideMenuDel
    var MenuNames = ["Profile","Tags","Following","Follower","Help"]
    var SystemImageNames = ["person","text.bubble","person.circle","person.circle.fill","questionmark"]
    func logoutView()-> some View{
        return
            Button(action: {
            self.showingAlert = true
        }){
            Image(systemName: "figure.wave.circle")
            Text("logout")
            
        }.alert(isPresented: $showingAlert){
            Alert(title: Text("ログアウトしますか")
                  ,primaryButton: .default(Text("はい"),
                        action:{
                            sideDel.logout()
                                           }), secondaryButton: .default(Text("いいえ")))
        }
    
    }
    var body: some View{
        
        VStack(alignment: .trailing){
            
            Spacer().frame(height:100)
            Button(action: {
                info = !info
            }){
                Image(systemName: "xmark.circle").resizable()
                    .frame(width: ProfileSize.width,height: ProfileSize.height)
                    .foregroundColor(/*@START_MENU_TOKEN@*/.red/*@END_MENU_TOKEN@*/)
            }
            HStack{
                Spacer()
                    .frame(width: 15)
                VStack(alignment: .leading) {
                    ForEach(0..<5){num in
                        Button(action: {
                            self.SelectedMenu = MenuNames[num]
                            sideDel.toggle(sidemenu: MenuNames[num])
                        }){
                            Image(systemName: SystemImageNames[num])
                            Text(MenuNames[num])
                        }
                    }
                    logoutView()

                }
                
            }

            Spacer()
        }
        
    }
}
//struct SideMenuView_Previews: PreviewProvider {
//    static var previews: some View {
//        SideMenuView()
//    }
//}
