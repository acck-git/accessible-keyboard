//
//  Top line sub view
//

import SwiftUI
import SwiftData

struct ToplineSubView: View {
  @EnvironmentObject var input: Input
  var body: some View {
    //[Top line container]---------------------
    HStack(spacing:20) {
      LGreyImageButton(image: "speaker.fill", action: {}).disabled(true).opacity(0.3)
      TextInput(text: input.inputText)
    }
    .padding(/*@START_MENU_TOKEN@*/.horizontal, 20.0/*@END_MENU_TOKEN@*/)
    .padding(.vertical, 20.0)
    .frame(maxWidth:.infinity, maxHeight:123)
  }
}

#Preview {
  ToplineSubView().environmentObject(Input())
}
