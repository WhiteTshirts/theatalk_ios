//
//  TimelineView.swift
//  theatalk-ios
//
//  Created by riku iwasaki on 2021/03/04.
//

import SwiftUI

struct TimelineView: View {
    @State var TagId = 0
    @State var SelectedRooms = false
    var body: some View {
        ZStack{
            //Color.red.ignoresSafeArea()
            VStack(alignment: .center){
                HStack{
                    ScrollView{
                        RoomList(RoomsVM: RoomsViewModel(), tagId:self.$TagId, IsSelected: self.$SelectedRooms)
                    }
                }
            }
        }

    }
}

struct TimelineView_Previews: PreviewProvider {
    static var previews: some View {
        TimelineView()
    }
}
