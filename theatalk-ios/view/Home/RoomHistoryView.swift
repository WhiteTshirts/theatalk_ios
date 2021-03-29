//
//  RoomHistoryView.swift
//  theatalk-ios
//
//  Created by riku iwasaki on 2021/03/02.
//

import SwiftUI

struct RoomHistoryView: View {
    @State var TagId = 0
    @State var SelectedRooms = false
    var body: some View {
        ZStack{
            VStack(alignment: .center){
                HStack{
                    ScrollView{
                        RoomList(RoomsVM: RoomsViewModelHistory(), tagId:self.$TagId)
                    }
                }
            }
        }

    }
}

