//
//  TagList.swift
//  theatalk-ios
//
//  Created by riku iwasaki on 2021/02/10.
//

import SwiftUI

protocol TagManage{
    func DeleteTag(tagId:Int)
    func AddTag(tagId:Int)
}
struct TagList: View ,TagManage{

    @ObservedObject var TagsVM: TagsViewModel
    @State var IsEditTag = false
    @State var textEntered = ""
    @State var SearchTagId = -1
    
    
    func DeleteTag(tagId: Int) {
        print("deleteded tag")
        TagsVM.DeleteTagFromUser(tagId: tagId)
    }
    
    func AddTag(tagId: Int) {
        print("added tag")
        TagsVM.AddTagToUser(tagId: tagId)
    }
    
    private func GetTags(tags:[Tag],isUserTag:Bool,color:Color) ->some View{
        var width = CGFloat.zero
        var height = CGFloat.zero
        
        return ZStack(alignment: .topLeading) {
            ForEach(tags){ tag in
                TagItemView(for: tag, color: color, isUserTag: isUserTag)
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
    func TagItemView(for tag:Tag,color:Color,isUserTag:Bool)->some View{
        return
            TagItem(for: tag.name,color: color)
                .padding(.all,8)
                .overlay(
                    Button(action: {
                        if(isUserTag){
                            DeleteTag(tagId: tag.id
                            )
                        }else{
                            AddTag(tagId: tag.id)
                        }
                    }, label: {
                        Image(systemName:isUserTag ? "minus.circle":"plus.circle")
                                .resizable()
                                .frame(width: 16,height: 16)
                        
                    }),alignment: .topTrailing
                    
                )
    }
    
    var body: some View {
        VStack{
            Text("登録タグ一覧")
            
            GetTags(tags: TagsVM.tags,isUserTag: false, color: Color.red)
            Text("ユーザタグ一覧")
            
            GetTags(tags: TagsVM.UserTags,isUserTag: true ,color: Color.green)


        }


        
    }
}

struct TagList_Previews: PreviewProvider {
    static var previews: some View {
        TagList(TagsVM: TagsViewModel(UserId: 1))
    }
}
