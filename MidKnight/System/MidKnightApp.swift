import SwiftUI

@main struct MidKnightApp: App {
  
  let environment: AppEnvironment
  
  var body: some Scene {
    WindowGroup {
      ContentView(environment.container)
    }
  }
  
  init() {
    environment = AppEnvironment.bootstrap()
  }
}
