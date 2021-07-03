//
//  TagsView.swift
//  theatalk-ios
//
//  Created by riku iwasaki on 2021/07/03.
//

import SwiftUI


func TagItem(for text:String,color:Color) -> some View{
    Text(text)
        .padding(.all,5)
        .font(.footnote)
        .background(color)
        .foregroundColor(.white)
        .cornerRadius(3)
}


func TagItemView(for tag:Tag,color:Color,isAddedTag:Bool,tagdelegate:TagManage)->some View{
    return
        TagItem(for: tag.name,color: color)
            .padding(.all,8)
            .overlay(
                Button(action: {
                    if(isAddedTag){
                        tagdelegate.DeleteTag(tag: tag)
                    }else{
                        tagdelegate.AddTag(tag: tag)
                    }
                }, label: {
                    Image(systemName:isAddedTag ? "minus.circle":"plus.circle")
                            .resizable()
                            .frame(width: 16,height: 16)
                }),alignment: .topTrailing
                
            )
}
func GetTags(tags:[Tag],isUserTag:Bool,color:Color) ->some View{
    var width = CGFloat.zero
    var height = CGFloat.zero
    
    return ZStack(alignment: .topLeading) {
        ForEach(tags){ tag in
            TagItem(for: tag.name, color: color)
                .padding(.all,8)
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
