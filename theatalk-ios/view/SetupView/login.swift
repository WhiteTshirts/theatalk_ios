//
//  Login.swift
//  theatalk-ios
//
//  Created by riku iwasaki on 2021/02/05.
//

import SwiftUI

struct SignupView:View{
    var authdel:Authdel
    @State var name:String=""
    @State var password:String=""
    @State var password_confirm:String=""
    var body: some View {
            Text("新規ユーザ作成")
            VStack(spacing: 24) {

                HStack{
                    TextField("username", text: self.$name)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(maxWidth:200)
                }
                HStack{
                    SecureField("パスワード", text: self.$password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(maxWidth:200)
                }
                HStack{
                    SecureField("パスワード確認", text: self.$password_confirm)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(maxWidth:200)
                }
            }

            Button(action: {
                self.authdel.signup(name: self.name, password: self.password)
            }) {
                Text("決定")
                    .fontWeight(.medium)
                     .frame(minWidth: 160)
                     .foregroundColor(.white)
                     .padding(12)
                     .background(Color.accentColor)
                     .cornerRadius(8)
            }
            Button(action: {
                self.authdel.ToggleLogin()
            }) {
                Text("loginする")
                    .fontWeight(.medium)
                     .frame(minWidth: 160)
                     .foregroundColor(.white)
                     .padding(12)
                     .background(Color.accentColor)
                     .cornerRadius(8)
            }
        
        
    }
    
}
struct LoginView:View{
    var authdel:Authdel
    @State var name:String=""
    @State var password:String=""
    var body: some View {
        Text("ログイン")

        VStack(spacing: 24) {

            HStack{
                TextField("username", text: self.$name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(maxWidth:200)
            }
            HStack{
                SecureField("パスワード", text: self.$password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(maxWidth:200)
            }
        }
        Button(action: {
            self.authdel.login(name: self.name, password: self.password)
        }) {
            Text("決定")
                .fontWeight(.medium)
                 .frame(minWidth: 160)
                 .foregroundColor(.white)
                 .padding(12)
                 .background(Color.accentColor)
                 .cornerRadius(8)
        }
        Button(action: {
            self.authdel.ToggleLogin()
        }) {
            Text("signupする")
                .fontWeight(.medium)
                 .frame(minWidth: 160)
                 .foregroundColor(.white)
                 .padding(12)
                 .background(Color.accentColor)
                 .cornerRadius(8)
        }
        
        

    }
    
}
protocol Authdel {
    func login(name:String,password:String)
    func signup(name:String,password:String)
    func ToggleLogin()
}

struct AuthView: View,Authdel {
    func login(name: String, password: String) {
        self.LoginVM.SetUser(name: name, password: password)
        profile.password = password
        profile.username = name
        self.LoginVM.login(){
            user, bool in
            guard let _ = user else{
                //error handle
                return
            }
            DispatchQueue.main.async {
                profile.token = g_user_token
                profile.token_invalid = false
                profile.user_Id = user?.id ?? -1
                self.session.user  = user
                self.session.isLogin = true
                
            }

        }
    }
    func ToggleLogin() {
        self.is_login = !(self.is_login)
    }
    
    func signup(name: String, password: String){
        self.LoginVM.SetUser(name: name, password: password)
        profile.password = password
        profile.username = name
        self.LoginVM.signup(){
            user, bool in
            guard let _ = user else{
                //error handle
                return
            }
            DispatchQueue.main.async {
                profile.token = g_user_token
                profile.token_invalid = false
                profile.user_Id = user?.id ?? -1
                self.session.user  = user
                self.session.isLogin = true
            }

        }
    }
    
    @EnvironmentObject var session: Session
    @ObservedObject var LoginVM = AuthViewModel()
    @ObservedObject var profile = UserProfile()
    @State var is_login = true
    typealias CompletionClosure = ((_ result:Int)->Bool)
    func login(){

    }
    var body: some View {
        NavigationView{
            VStack(alignment:.center){
                Text("Theatalk")
                    .font(.system(size:48,weight:.heavy))
                if(is_login){
                    LoginView(authdel: self)
                }else{
                    SignupView(authdel: self)
                }
            }

        }


    }
    

}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
    }
}
