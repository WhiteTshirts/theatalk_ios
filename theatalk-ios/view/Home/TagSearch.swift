//
//  TagSearch.swift
//  theatalk-ios
//
//  Created by riku iwasaki on 2021/03/31.
//

import SwiftUI

struct TagSearch: View {
    @Binding var TagId:Int
    @ObservedObject var TagVM:TagsViewModel
    @State  var keyword = ""
    var body: some View {
        VStack{
            TextField("",text:$keyword)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            List{
                Text("aa")
            }
            
        }
    }
}

