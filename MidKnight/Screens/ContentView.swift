import Combine
import SwiftUI

struct ContentView: View {
  
  private let container: Container
  
  init(_ container: Container) {
    self.container = container
  }
  
  @State private var currentPage: Container.Routes = .loading
  
  var body: some View {
    
    ZStack {
      
      GeometryReader { reader in
        
        Image("background")
          .resizable()
          .aspectRatio(1, contentMode: .fill)
          .frame(width: reader.size.width, height: reader.size.height)
        
      }
      .ignoresSafeArea()
      .overlay(.ultraThinMaterial)
      
      Group {
        switch currentPage {
        case .loading:
          ProgressView()
            .onAppear {
              container.appState[\.currentPage] = .today
            }
        case .today:
          TodayScreen()
        case .history:
          Text("")
        case .settings:
          SettingsScreen()
        case .targets:
          Text("")
        case .createTarget:
          Text("")
        }
      }
      .inject(container)
      
    }
    .onReceive(currentPageUpdate) { newPage in
      DispatchQueue.main.async {
        withAnimation(.spring()) {
          self.currentPage = newPage
        }
      }
    }
  }
}


// MARK: - Updates

private extension ContentView {
  var currentPageUpdate: AnyPublisher<Container.Routes, Never> {
    container.appState.updates(for: \.currentPage)
  }
}
