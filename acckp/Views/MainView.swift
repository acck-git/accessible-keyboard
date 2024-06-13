//
//  Main screen
//

import SwiftUI
import SwiftData


struct MainView: View {
  @StateObject var gVars = GlobalVars()
  @State var alert: Bool = false
  var body: some View {
    //[Main container]---------------------
    switch gVars.screen{
    case GlobalVars.screens.settings:
      SettingsView().environmentObject(gVars)
    case GlobalVars.screens.teacher:
      VStack (spacing: 0.0) {
        LetterButton(text: "Teacher page", action: {alert = true})
      }
      .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
      .padding(/*@START_MENU_TOKEN@*/.horizontal, 0.0/*@END_MENU_TOKEN@*/)
      .padding(.vertical, -22.0)
      .alert("Nothing to display here.", isPresented: $alert, actions: {})
      
    default:
      let main = VStack (spacing: 0.0) {
        ToplineSubView().environmentObject(gVars)
          .frame(height: StaticData.screenheight * (1/7))
          .padding(.vertical, 0.0)
        //-----------------------
        Divider()
          .frame(height: 5.0)
          .foregroundColor(/*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/)
          .overlay(.black)
        //-----------------------
        KeyboardSubView().environmentObject(gVars)
      }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .padding(/*@START_MENU_TOKEN@*/.horizontal, 0.0/*@END_MENU_TOKEN@*/)
        .padding(.vertical, 0.0)
      if gVars.imageZoom { main
        .overlay(MassiveImageButton(
          image: gVars.image, action: { gVars.imageZoom = false })
        )
      }
      else { main }
    }
  }
}

#Preview {
  MainView()
}
