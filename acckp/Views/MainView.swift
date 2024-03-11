//
//  Main screen
//

import SwiftUI
import SwiftData

struct MainView: View {
  var body: some View {
    //[Main container]---------------------
    VStack (spacing: 0.0) {
      ToplineSubView()
      Divider()
        .frame(height: 5.0)
        .foregroundColor(/*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/)
        .overlay(.black)
      KeyboardSubView(board: 0)
    }
    .frame(
      minWidth: 0,
      maxWidth: .infinity,
      minHeight: 0,
      maxHeight: .infinity
    )
    .padding(/*@START_MENU_TOKEN@*/.horizontal, 0.0/*@END_MENU_TOKEN@*/)
    .padding(.vertical, -22.0)
  }
}

#Preview {
  MainView()
}
