//
//  InitialView.swift
//  theatalk-ios
//
//  Created by riku iwasaki on 2021/02/13.
//

import SwiftUI

struct InitialView: View {
    @EnvironmentObject var session: Session
    var body: some View {
        if session.user != nil{
            Home().environmentObject(session)
        }else{
            LoginView().environmentObject(session)
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
