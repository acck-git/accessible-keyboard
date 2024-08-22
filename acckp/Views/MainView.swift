//
//  Main screen
//

import SwiftUI
import SwiftData

struct MainView: View {
  @Environment(\.modelContext) private var ModelContext
  @ObservedObject var gVars = GlobalVars.get(screen: GlobalVars.screens.blank)
  var NilData = Data()
  var body: some View {
    //[Main container]---------------------
    VStack () {
      switch gVars.screen {
      case GlobalVars.screens.blank:
        VStack{}.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)  .background(Color(hex:StaticData.bg1_col[gVars.colorSet]))
      case GlobalVars.screens.settings:
        SettingsView()
      case GlobalVars.screens.teacher:
        TeacherView()
      case GlobalVars.screens.stats:
        StatisticsView()
      case GlobalVars.screens.images:
        ImagesView()
      default:
        let main = VStack (spacing: 0.0) {
          ToplineSubView()
            .frame(height: StaticData.screenheight * (1/7))
            .padding(.vertical, 0.0)
            .background(Color(hex:StaticData.bg1_col[gVars.colorSet]))
          //-----------------------
          Divider()
            .frame(height: 5.0)
            .foregroundColor(Color(hex:StaticData.text_col[gVars.colorSet]))
            .overlay(Color(hex:StaticData.text_col[gVars.colorSet]))
          //-----------------------
          KeyboardSubView()
        }
          .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
          .padding(.horizontal, 0.0)
          .padding(.vertical, 0.0)
        if gVars.imageZoom {
          if gVars.image!.image != NilData {
            main.overlay(MassiveImageButtonNew(
              image: gVars.image!.image!, action: { gVars.imageZoom = false })
            )
          }
          else {
            main.overlay(MassiveImageButton(
              image: gVars.image!.key, action: { gVars.imageZoom = false })
            )}
        }
        else { main }
      }
    }
    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
    .padding(.all, 0.0)
    .ignoresSafeArea(.keyboard)
    .onAppear(perform: FetchData)
  }
  //[Load users from database]------------
  @MainActor private func FetchData() {
    let query = FetchDescriptor<UserData>()
    let queryimg = FetchDescriptor<ImageData>()
    do {
      gVars.users = try ModelContext.fetch(query)
      let user = gVars.loginStudent()
      if user != nil {
        ModelContext.insert(user!)
        print("Created user \(user!.student).")
      }
      else {
        print("Loaded user \(gVars.student).")
      }
    }
    catch {
      fatalError("Could not fetch users: \(error)")
    }
    do {
      let images = try ModelContext.fetch(queryimg)
      if images.count != 0 {
        gVars.images = images[0]
      }
      else{
        gVars.images = ImageData()
        ModelContext.insert(gVars.images!)
      }
      gVars.loadImages()
    }
    catch {
      fatalError("Could not fetch images: \(error)")
    }
    gVars.screen = GlobalVars.screens.main
  }
}

#Preview {
  MainView().modelContainer(for: [UserData.self, ImageData.self])
}
