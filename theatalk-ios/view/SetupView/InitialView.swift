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
                
                HomeLayoutView(TagsVM: TagsViewModel(UserId: profile.user_Id)).environmentObject(session)
                //Home( TagsVM: TagsViewModel(UserId: profile.user_Id)).environmentObject(session)
            }else{
                AuthView().environmentObject(session)
            }
        }.onAppear{
            if(profile.username != ""){
                self.session.user = User(name: profile.username,user_id: profile.user_Id, password: profile.password)
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
