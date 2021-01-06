//
//  Home.swift
//  theatalk-ios
//
//  Created by riku iwasaki on 2020/12/16.
//

import SwiftUI

struct Home: View {
    @State var textEntered = ""

    var body: some View {

        VStack{
            Text("theatalk")
                .foregroundColor(Color.red)
            HStack{
                Rectangle().fill().frame(width:40,height: 40)//写真
                TextField("検索",text:$textEntered)
                Button(action:{
                    print("Button Tapped")
                }){
                    Text("+")
                        .font(.largeTitle)
                        
                }
            }
            ScrollView(.vertical){
                VStack(alignment: .leading){
                    ForEach(0..<10){_ in
                        HStack(){
                            Rectangle().fill(Color.red)
                                .frame(width:140,height: 100)
                            Rectangle().fill(Color.red)
                                .frame(width:140,height: 100)
                        }
                    }
                }
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
