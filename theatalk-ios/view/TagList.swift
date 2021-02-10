//
//  TagList.swift
//  theatalk-ios
//
//  Created by riku iwasaki on 2021/02/10.
//

import SwiftUI

struct TagList: View {
    @ObservedObject var TagsVM: TagsViewModel

    var body: some View {
        List{
            HStack{

                ForEach(TagsVM.tags){ tag in
                    
                    Text("\(tag.name)")
                }
            }
        }.onAppear{
            TagsVM.load()
        }
 
        
        
    }
}

struct TagList_Previews: PreviewProvider {
    static var previews: some View {
        //TagList()
        TagList(TagsVM: TagsViewModel())
    }
}
