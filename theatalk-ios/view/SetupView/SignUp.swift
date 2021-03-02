//
//  SignUp.swift
//  theatalk-ios
//
//  Created by riku iwasaki on 2021/02/07.
//

import SwiftUI

struct SignUpView: View {
    @State private var userName = ""
    @State private var password = ""
    @State private var password_confirm = ""
    
    var body: some View {
        ZStack(alignment: .topTrailing){
            VStack(alignment: .center){
                HStack{
                    Text("ユーザ名")
                    TextField("username", text: $userName)
                }
                HStack{
                    Text("パスワード")
                    SecureField("*******", text: $password)
                }
                HStack{
                    Text("パスワード確認")
                    SecureField("*******", text: $password_confirm)
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
            


            }.frame(width: 300, height: 400, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            Button(action: {
                
            }, label: {
                Text("ログインする")
            })
        }



    }
    func checkInput(){

    }
}


struct SignUp_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
