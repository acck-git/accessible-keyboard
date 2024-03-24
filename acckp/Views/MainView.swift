//
//  Main screen
//

import SwiftUI
import SwiftData

struct MainView: View {
  @StateObject var gVars = GlobalVars()
  var body: some View {
    //[Main container]---------------------
    VStack (spacing: 0.0) {
      ToplineSubView().environmentObject(gVars)
      Divider()
        .frame(height: 5.0)
        .foregroundColor(/*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/)
        .overlay(.black)
      KeyboardSubView().environmentObject(gVars)
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
