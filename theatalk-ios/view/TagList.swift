//
//  TagList.swift
//  theatalk-ios
//
//  Created by riku iwasaki on 2021/02/10.
//

import SwiftUI

struct AllTagsListView: View{
    var body : some View{
        Text("a")
    }
}

struct TagList: View {
    @ObservedObject var TagsVM: TagsViewModel
    private func GetTags(tags:[Tag],color:Color) ->some View{
        var width = CGFloat.zero
        var height = CGFloat.zero
        
        return ZStack(alignment: .topLeading) {
            ForEach(tags){ tag in
                TagItem(for: tag.name,color: color)
                    .padding(.all,5)
                    .alignmentGuide(.leading, computeValue: { d in
                      if abs(width - d.width) > 300 {
                        width = 0
                        height -= d.height
                      }
                      let result = width
                        if tag == tags.last {
                        width = 0
                      } else {
                        width -= d.width
                      }
                      return result
                    })
                    .alignmentGuide(.top, computeValue: { _ in
                      let result = height
                        if tag == tags.last {
                        height = 0
                      }
                      return result
                    })
                
            }
        }
      }
    func TagItem(for text:String,color:Color) -> some View{
        Text(text)
            .padding(.all,5)
            .font(.footnote)
            .background(color)
            .foregroundColor(.white)
            .cornerRadius(3)
    }
    
    var body: some View {
        VStack{
            Text("ユーザタグ一覧")
            
            GetTags(tags: TagsVM.UserTags, color: Color.green)
            Text("登録タグ一覧")
            
            GetTags(tags: TagsVM.tags, color: Color.red)

        }


        
    }
}

struct TagList_Previews: PreviewProvider {
    static var previews: some View {
        TagList(TagsVM: TagsViewModel(UserId: 1))
    }
}
