//
//  Main screen
//

import SwiftUI
import SwiftData


struct MainView: View {
  @Environment(\.modelContext) private var ModelContext
  @ObservedObject var gVars = GlobalVars.get()
  @State var alert: Bool = false
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
          //-----------------------
          Divider()
            .frame(height: 5.0)
            .foregroundColor(.black)
            .overlay(.black)
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
      let result = gVars.loginStudent()
      if result != nil {
        ModelContext.insert(result!)
        //try ModelContext.save()
        result!.printUser()
        print("Created user \(result!.student).")
      }
      else {
        gVars.user.printUser()
        print("Loaded user \(gVars.student).")
      }
    }
    catch {
      fatalError("Could not create fetch users: \(error)")
    }
  }
}

#Preview {
  MainView().modelContainer(for: UserData.self)
}
