//
//  UserProfileView.swift
//  theatalk-ios
//
//  Created by riku iwasaki on 2021/02/16.
//

import SwiftUI

struct UserProfileView: View {
    var user:User
    @ObservedObject var TagsVM: TagsViewModel
    var body: some View {
        VStack{
            Text("名前:\(user.name)")
            Text("フォロー数:3")
            Text("フォロワー数:2")
            Text("登録タグ一覧")
            GetTags(tags: TagsVM.UserTags, isUserTag: true, color: Color.red)
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
    private func GetTags(tags:[Tag],isUserTag:Bool,color:Color) ->some View{
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
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        AnyView(UserProfileView(user:mockUserData,TagsVM: TagsViewModel(UserId: 0)))
    }
}
