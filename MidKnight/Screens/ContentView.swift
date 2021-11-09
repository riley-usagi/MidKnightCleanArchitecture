import Combine
import SwiftUI

struct ContentView: View {
  
  private let container: Container
  
  @State private var currentPage: Container.Routes = .loading
  
  var body: some View {
    
    Group {
      
      switch currentPage {
      case .loading:
        LoadingScreen()
      case .today:
        TodayScreen()
      case .history:
        Text("")
      case .settings:
        Text("")
      case .targets:
        Text("")
      case .createTarget:
        Text("")
      }
      
    }
    .onReceive(currentPageUpdate) { page in
      DispatchQueue.main.async {
        withAnimation(.spring()) {
          currentPage = page
        }
      }
    }
    .inject(container)
  }
  
  init(_ container: Container) {
    self.container = container
  }
}

extension ContentView {
  
  /// Подписка под обновление статуса текущей страницы
  var currentPageUpdate: AnyPublisher<Container.Routes, Never> {
    container.appState.updates(for: \.currentPage)
  }
}
