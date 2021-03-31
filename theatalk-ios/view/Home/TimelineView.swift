//
//  TimelineView.swift
//  theatalk-ios
//
//  Created by riku iwasaki on 2021/03/04.
//

import SwiftUI
struct TimelineBarView: View {
    var body: some View {
        HStack{
            
        }
    }
}
struct TimelineView: View {
    @State var TagId = 0
    var body: some View {
        ZStack{
            VStack(alignment: .center){
                HStack{
                    ScrollView{
                        RoomList(RoomsVM: RoomsViewModel(), tagId:self.$TagId)
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
