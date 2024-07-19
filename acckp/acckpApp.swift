//
//  Launch app
//

import SwiftUI
import SwiftData

@main
struct acckpApp: App {
  var container: ModelContainer = {
    let schema = Schema([UserData.self])
    let configuration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
    do { 
      GlobalVars.container = try ModelContainer(for: schema, configurations: [configuration])
      return GlobalVars.container!
    }
    catch { fatalError("Could not create ModelContainer: \(error)") }
  }()
  @StateObject var gVars = GlobalVars.get()
  var body: some Scene {
    WindowGroup {
      MainView()
    }
    .modelContainer(container)
  }
}
