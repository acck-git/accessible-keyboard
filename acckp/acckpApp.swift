//
//  Launch app
//

import SwiftUI
import SwiftData

@main
struct acckpApp: App {
  var body: some Scene {
    WindowGroup {
      MainView()
    }
    .modelContainer(for:[
      UserData.self
    ])
  }
}
