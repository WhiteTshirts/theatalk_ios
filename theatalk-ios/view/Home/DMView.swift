//
//  DMView.swift
//  theatalk-ios
//
//  Created by riku iwasaki on 2021/03/02.
//

import SwiftUI

struct DMView: View {
    var body: some View {
        
        ZStack{
            List{
                
                ForEach(0..<10){ num in
                    Text("sample")
                    
                }
            }

        }
    }
}

struct DMView_Previews: PreviewProvider {
    static var previews: some View {
        DMView()
    }
}
