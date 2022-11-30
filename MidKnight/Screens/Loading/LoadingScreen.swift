import SwiftUI

struct LoadingScreen: View {
  
  @StateObject private var navigationStore = NavigationStore(
    urlHandler: GlobalUrlHandler(),
    activityHandler: GlobalActivityHandler()
  )
  
  @SceneStorage("navigation")
  
  private var navigationData: Data?
  
  var body: some View {
    
    NavigationStack(path: $navigationStore.path) {
      
      ContentView()
      
        .environmentObject(navigationStore)
      
        .onOpenURL { navigationStore.handle($0) }
      
        .task {
          if let navigationData {
            navigationStore.restore(from: navigationData)
          }
          
          for await _ in navigationStore.$path.values {
            navigationData = navigationStore.encoded()
          }
        }
    }
  }
}

struct GlobalUrlHandler: UrlHandler {
  func handle(_ url: URL, mutating: inout NavigationPath) {}
}

struct GlobalActivityHandler: ActivityHandler {
  func handle(_ activity: NSUserActivity, mutating: inout NavigationPath) {}
}
