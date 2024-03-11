//
//  Top line sub view
//

import SwiftUI
import SwiftData

struct ToplineSubView: View {
  var body: some View {
    //[Top line container]---------------------
    HStack(spacing:20) {
      LGreyImageButton(image: "speaker.fill", action: {})
      //[Text input]---------------------------
      Text("טֶקסט לֶהָמחָשָה")
        .lineLimit(1)
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/ , minHeight: 80, alignment:.trailing)
        .padding(.horizontal)
        .foregroundColor(.black)
        .font(.system(size: 35, weight: .heavy))
        .overlay(RoundedRectangle(cornerRadius: 5)
          .stroke(.black, lineWidth: 2))
    }
    .padding(/*@START_MENU_TOKEN@*/.horizontal, 20.0/*@END_MENU_TOKEN@*/)
    .padding(.vertical, 20.0)
    .frame(maxWidth:.infinity, maxHeight:123)
  }
}

#Preview {
  ToplineSubView()
}
