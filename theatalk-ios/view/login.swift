//
//  Login.swift
//  theatalk-ios
//
//  Created by riku iwasaki on 2021/02/05.
//

import SwiftUI

struct LoginView: View {
    @State var userName = ""
    @State var password = ""
    @EnvironmentObject var session: Session
    @ObservedObject var LoginVM:AuthViewModel
    var body: some View {
        VStack(alignment: .center){
            HStack{
                Text("ユーザ名")
                TextField("username", text: $userName)
            }
            HStack{
                Text("パスワード")
                SecureField("*******", text: $password)
            }
            Button(action: {
                checkInput()
            }) {
                Text("決定")
                    .foregroundColor(Color.red)
                
            }
            if(userName == ""){
                Text("ユーザ名が入力されていません")
            }
            if(password == ""){
                Text("passwordが入力されていません")
            }
        }.frame(width: 250, height: 300, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)

    }
    func checkInput()->Bool{
        if(userName == ""||password == ""){
            return false
        }else{
            return true
        }
    }
    
    func login(){
        if(checkInput()){
            
            
        }else{
            
        }
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(LoginVM:AuthViewModel()).environmentObject(Session(login: false, user: mockUserData))
    }
}
