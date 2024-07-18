//
//  Main screen
//

import SwiftUI
import SwiftData


struct MainView: View {
  @Environment(\.modelContext) private var ModelContext
  @StateObject var gVars: GlobalVars
  @State private var user: UserData!
  @State var boards: [Bool]
  @State var alert: Bool = false
  init (gVars: GlobalVars){
    //boards = StaticData.boards
    _gVars = StateObject(wrappedValue: gVars)
    if gVars != nil {
      print("has stuff")
      print(gVars.user)
    }
    else {
      print("no stuff")
    }
    _boards = State(wrappedValue: gVars.getBoards())
  }
  var body: some View {
    //[Main container]---------------------
    VStack (){
      switch gVars.screen{
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
            .foregroundColor(/*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/)
            .overlay(.black)
          //-----------------------
          KeyboardSubView()
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
    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
    .padding(/*@START_MENU_TOKEN@*/.horizontal, 0.0/*@END_MENU_TOKEN@*/)
    .padding(.vertical, 0.0)
    .ignoresSafeArea(.keyboard)
    .onAppear(perform: fetchUsers)
  }
  @MainActor private func fetchUsers(){
    let query = FetchDescriptor<UserData>()
    do {
      gVars.users = try ModelContext.fetch(query)
      print(gVars.users.count)
      let result = gVars.loginStudent()
      if result != nil {
        ModelContext.insert(result!)
        //try ModelContext.save()
        user = result!
        print("Created user \(result!.student).")
      }
      else {
        user = gVars.user
        print("Loaded user \(user.student).")
      }
      user.printUser()
    }
    catch {
      fatalError("Could not create fetch users: \(error)")
    }
  }
}

#Preview {
  MainView(gVars: GlobalVars.get()).modelContainer(for: UserData.self)
}
