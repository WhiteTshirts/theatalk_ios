//
//  UserView.swift
//  theatalk-ios
//
//  Created by Kyosuke Yokota on 2021/01/27.
//

import SwiftUI

struct UserView: View {
    var body: some View {
        VStack {
            
            VStack{
                HStack{
                    VStack{
                        Circle()
                            .stroke(Color.black, lineWidth: 2)
                            .frame(width:100,height:100)
                            
                        Text("Profile")
                        Text("名前")
                    }
                    VStack{
                        Button(action: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/{}/*@END_MENU_TOKEN@*/) {
                            Text("フォロー")
                        }
                        HStack{
                            Text("フォロー")
                            Text("フォロワー")
                        }
                    }
                }
                HStack{
                    Text("#あつ森")
                    Text("#APEX")
                }
            }
        }
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView()
    }
}
