//
//  AvaterSelectView.swift
//  theatalk-ios
//
//  Created by riku iwasaki on 2021/06/12.
//

import SwiftUI
protocol AvaterRegist {
    func avaterRegist(avaterId:Int)
}
struct AvaterSelectView: View {
    let columns: [GridItem] = [GridItem(.adaptive(minimum: 100, maximum: 150))]
    var AvaterRegist:AvaterRegist
    @State var avaterId:Int = -1
    var body: some View{
        ScrollView{
            LazyVGrid(columns:columns,spacing:20){
                ForEach(0..<image_names.count){index in
                    
                    VStack{
                        Button(action: {
                            avaterId = index
                        }, label: {
                            if(index == avaterId){
                                Image(image_names[index])
                                    .resizable()
                                    .frame(width:100,height: 100)
                                    .border(Color.red,width: 5)
                            }else{
                                Image(image_names[index])
                                    .resizable()
                                    .frame(width:100,height: 100)
                            }
                        })
                    }
                }
            }.padding()
            Button(action: {
                if(avaterId != -1){
                    AvaterRegist.avaterRegist(avaterId: avaterId)
                }
            }, label: {
                Text("登録")
            })
        }
    }
}
