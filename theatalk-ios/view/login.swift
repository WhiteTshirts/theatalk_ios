//
//  Login.swift
//  theatalk-ios
//
//  Created by riku iwasaki on 2021/02/05.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var session: Session
    @ObservedObject var LoginVM = AuthViewModel()
    typealias CompletionClosure = ((_ result:Int)->Bool)
    var body: some View {
        NavigationView{
            VStack(alignment: .center){
                HStack{
                    Text("ユーザ名")
                    TextField("username", text: $LoginVM.userName)
                }
                HStack{
                    Text("パスワード")
                    SecureField("*******", text: $LoginVM.password)
                }
                Button(action: {
                    self.LoginVM.login(){
                        user, bool in
                        guard let _ = user else{
                            //error handle
                            return
                        }
                        self.session.user  = user
                        self.session.isLogin = true
                    }
                }) {
                    Text("決定")
                        .foregroundColor(Color.red)
                    
                }
            }
        }


    }
    

}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(LoginVM:AuthViewModel()).environmentObject(Session(login: false, user: mockUserData))
    }
}
