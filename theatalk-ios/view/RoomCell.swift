//
//  RoomCell.swift
//  theatalk-ios
//
//  Created by riku iwasaki on 2021/01/27.
//

import SwiftUI

struct RoomCell: View {
    @Environment  var room_:Room

    var body: some View {
        Text(room_.name)
    }
}

//struct RoomCell_Previews: PreviewProvider {
//    static var previews: some View {
//        RoomCell(room: ModelData().rooms[0])
//
//    }
//}
