import SwiftUI

@main struct MidKnightApp: App {
  
  let environment: AppEnvironment
  
  var body: some Scene {
    
    WindowGroup {
      
      GeometryReader { reader in
        
        ContentView(environment.container, reader.size)
          .preferredColorScheme(.light)
      }
    }
  }
  
  init() {
    environment = AppEnvironment.bootstrap()
  }
}
