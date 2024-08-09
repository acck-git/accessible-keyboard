//
//  Main screen
//

import SwiftUI
import SwiftData

struct MainView: View {
  @Environment(\.modelContext) private var ModelContext
  @ObservedObject var gVars = GlobalVars.get()
  var body: some View {
    //[Main container]---------------------
    VStack () {
      switch gVars.screen {
      case GlobalVars.screens.settings:
        SettingsView()
      case GlobalVars.screens.teacher:
        TeacherView()
      case GlobalVars.screens.stats:
        StatisticsView()
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
        if gVars.imageZoom { main
          .overlay(MassiveImageButton(
            image: gVars.image, action: { gVars.imageZoom = false })
          )
        }
        else { main }
      }
    }
    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
    .padding(.all, 0.0)
    .ignoresSafeArea(.keyboard)
    .onAppear(perform: fetchUsers)
  }
  //[Load users from database]------------
  @MainActor private func fetchUsers() {
    let query = FetchDescriptor<UserData>()
    do {
      gVars.users = try ModelContext.fetch(query)
      print(gVars.users.count)
      let user = gVars.loginStudent()
      if user != nil {
        ModelContext.insert(user!)
        //try ModelContext.save()
        user!.printUser()
        print("Created user \(user!.student).")
      }
      else {
        gVars.user.printUser()
        print("Loaded user \(gVars.student).")
      }
    }
    catch {
      fatalError("Could not fetch users: \(error)")
    }
  }
}

#Preview {
  MainView().modelContainer(for: UserData.self)
}
