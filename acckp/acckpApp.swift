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
      let urlApp = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).last
             let url = urlApp!.appendingPathComponent("default.store")
             if FileManager.default.fileExists(atPath: url.path) {
                 print("swiftdata db at \(url.absoluteString)")
             }
      GlobalVars.container = try ModelContainer(for: schema, configurations: [configuration])
      return GlobalVars.container!
    }
    catch { fatalError("Could not create ModelContainer: \(error)") }
  }()
  var body: some Scene {
    WindowGroup {
      MainView()
    }
    .modelContainer(container)
  }
}
