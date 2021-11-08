import SwiftUI

struct LoadingScreen: View {
  
  @Environment(\.container) var container: Container
  
  var body: some View {
    ProgressView()
      .onAppear {
        
        // Здесь будет происходить настройка первоначальных флагов
        if !(UserDefaults.standard.bool(forKey: "HasLaunchedOnce")) {
          UserDefaults.standard.set(true, forKey: "HasLaunchedOnce")
        }
        
        container.appState.value.currentPage = .today
      }
  }
}
