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
        NavigationView{
            VStack(alignment: .center){
                Text("新規ユーザ作成")
                HStack{
                    Text("ユーザ名")
                    TextField("username", text: self.$name)
                }
                HStack{
                    Text("パスワード")
                    SecureField("*******", text: self.$password)
                }
                HStack{
                    Text("パスワード")
                    SecureField("*******", text: self.$password_confirm)
                }
                Button(action: {
                    self.authdel.login(name: self.name, password: self.password)
                }) {
                    Text("決定")
                        .foregroundColor(Color.red)
                }
                Button(action: {
                    self.authdel.ToggleLogin()
                }) {
                    Text("loginする")
                        .foregroundColor(Color.red)
                }
            }
        }
    }
    
}
struct LoginView:View{
    var authdel:Authdel
    @State var name:String=""
    @State var password:String=""
    var body: some View {
        NavigationView{
            VStack(alignment: .center){
                Text("ログイン")

                HStack{
                    Text("ユーザ名")
                    TextField("username", text: self.$name)
                }
                HStack{
                    Text("パスワード")
                    SecureField("*******", text: self.$password)
                }
                Button(action: {
                    self.authdel.login(name: self.name, password: self.password)
                }) {
                    Text("決定")
                        .foregroundColor(Color.red)
                }
                Button(action: {
                    self.authdel.ToggleLogin()
                }) {
                    Text("signupする")
                        .foregroundColor(Color.red)
                }
            }
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
            profile.token = g_user_token
            self.session.user  = user
            self.session.isLogin = true
        }
    }
    func ToggleLogin() {
        self.is_login = !(self.is_login)
    }
    
    func signup(name: String, password: String) {
        self.LoginVM.SetUser(name: name, password: password)
        profile.password = password
        profile.username = name
        self.LoginVM.signup(){
            user, bool in
            guard let _ = user else{
                //error handle
                return
            }
            profile.token = g_user_token
            self.session.user  = user
            self.session.isLogin = true
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
        if(is_login){
            LoginView(authdel: self)
        }else{
            SignupView(authdel: self)
        }

    }
    

}

//struct Login_Previews: PreviewProvider {
//    static var previews: some View {
//        LoginView(authdel: <#Authdel#>, LoginVM:AuthViewModel()).environmentObject(Session(login: false, user: mockUserData))
//    }
//}
