//
//  InitialView.swift
//  theatalk-ios
//
//  Created by riku iwasaki on 2021/02/13.
//

import SwiftUI

struct InitialView: View {
    @EnvironmentObject var session: Session
    @ObservedObject var profile = UserProfile()

    var body: some View {
        VStack{
            if session.user != nil{
                Home().environmentObject(session)
            }else{
                LoginView().environmentObject(session)
            }
        }.onAppear{
            if(profile.username != ""){
                print(profile.username)
                self.session.user = User(name_: profile.username, password_: profile.password)
                g_user_token = profile.token

            }
            if(profile.token != ""){
                g_user_token = profile.token
                self.session.isLogin = true
            }
            
        }

    }
}

struct InstructionView:View{
    var body: some View{
        Text("this is first page")
    }
}
//
//struct InitialView_Previews: PreviewProvider {
//    static var previews: some View {
//        InitialView()
//    }
//}
