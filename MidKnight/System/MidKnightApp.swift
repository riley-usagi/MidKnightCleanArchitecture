import Combine
import SwiftUI

var update: PassthroughSubject<Update, Never> = .init()
var route: CurrentValueSubject<Route, Never> = .init(.loading)

@main struct MidKnightApp: App {
  
  @State var path: [Route] = [.loading]
  
  var body: some Scene {
    
    WindowGroup {
      
      NavigationStack(path: $path) {
        
        ContentView()
        
          .navigationDestination(for: Route.self) { route in
            
            switch route {
              
            case .loading:
              LoadingScreen()
              
            case .newDay:
              Text("New Day")
              
            default:
              EmptyView()
            }
          }
      }
      
      .onReceive(route) { newRoute in
        switch newRoute {
          
        case .loading:
          path.removeAll()
          
        case .newDay:
          path.removeAll()
          path.append(.newDay)
          
        case .home:
          path.removeAll()
        }
      }
    }
  }
}

enum Update {
  case stub
}

enum Route: Hashable {
  case loading
  case newDay
  case home
}
