//
//  ContentView.swift
//  theatalk-ios
//
//  Created by riku iwasaki on 2020/12/16.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Hello, world!aa")
                .font(.title)
            HStack {
                Text("haaadfsfsfsdfdfsdf")
                    .font(.subheadline)
                
                Text("caalifolnis")
                    .font(.subheadline)
            }
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
