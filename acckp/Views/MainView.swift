//
//  Main screen
//

import SwiftUI
import SwiftData


struct MainView: View {
  @StateObject var gVars = GlobalVars()
  @State var alert: Bool = false
  init(){
    //while (gVars.user == nil) {
      //sleep(1)
      //print("hi")
    //}
  }
  var body: some View {
      //[Main container]---------------------
      switch gVars.screen{
      case GlobalVars.screens.settings:
        SettingsView(boards: [true,false,false,false,false,false]).environmentObject(gVars)
      case GlobalVars.screens.teacher:
        TeacherView(boards: gVars.getBoards()).environmentObject(gVars)
          .ignoresSafeArea(.keyboard)
      case GlobalVars.screens.stats:
        StatisticsView(stats: gVars.getStats()).environmentObject(gVars)
          .ignoresSafeArea(.keyboard)
      default:
        let main = VStack (spacing: 0.0) {
          ToplineSubView()
            .frame(height: StaticData.screenheight * (1/7))
            .padding(.vertical, 0.0).environmentObject(gVars)
          //-----------------------
          Divider()
            .frame(height: 5.0)
            .foregroundColor(/*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/)
            .overlay(.black)
          //-----------------------
          KeyboardSubView(boards: [true,true,false,false,false,false]).environmentObject(gVars)
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
