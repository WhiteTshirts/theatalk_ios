//
//  RoomList.swift
//  theatalk-ios
//
//  Created by riku iwasaki on 2021/01/13.
//

import SwiftUI

struct RoomList: View {
    var room: Room

    var body: some View {
        HStack {
            room.image
                .resizable()
                .frame(width: 50, height: 50)
            Text(room.name)

            Spacer()
        }
    }
}

struct RoomList_Previews: PreviewProvider {
    static var previews: some View {
        Group {
        }
        .previewLayout(.fixed(width: 300, height: 70))
    }
}
