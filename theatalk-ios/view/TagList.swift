//
//  TagList.swift
//  theatalk-ios
//
//  Created by riku iwasaki on 2021/02/10.
//

import SwiftUI

struct TagList: View {
    @ObservedObject var TagsVM = TagsViewModel()
    private func GetTags() ->some View{
        var width = CGFloat.zero
        var height = CGFloat.zero
        
        return ZStack(alignment: .topLeading) {
            ForEach(TagsVM.tags){ tag in
                TagItem(for: tag.name)
                    .padding(.all,5)
                    .alignmentGuide(.leading, computeValue: { d in
                      if abs(width - d.width) > 300 {
                        width = 0
                        height -= d.height
                      }
                      let result = width
                        if tag == TagsVM.tags.last {
                        width = 0
                      } else {
                        width -= d.width
                      }
                      return result
                    })
                    .alignmentGuide(.top, computeValue: { _ in
                      let result = height
                        if tag == TagsVM.tags.last {
                        height = 0
                      }
                      return result
                    })
                
            }
        }
      }
    func TagItem(for text:String) -> some View{
        Text(text)
            .padding(.all,5)
            .font(.footnote)
            .background(Color.red)
            .foregroundColor(.white)
            .cornerRadius(3)
    }
    var body: some View {
        VStack{
            Text("タグ一覧")
            
            GetTags()
        }


        
    }
}

struct TagList_Previews: PreviewProvider {
    static var previews: some View {
        TagList()
    }
}
