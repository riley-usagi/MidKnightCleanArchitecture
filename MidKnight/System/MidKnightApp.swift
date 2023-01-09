import Combine
import SwiftUI

var update: PassthroughSubject<Update, Never> = .init()

@main struct MidKnightApp: App {
    
  @ObservedObject var router = Router.shared
  
  var body: some Scene {
    
    WindowGroup {
      
      NavigationStack(path: $router.path) {
        
        ContentView()
        
          .navigationDestination(for: Route.self) { route in
            
            switch route {
              
            case .loading:
              LoadingScreen()
              
            case .main:
              Text("Main Screen")
            }
          }
      }
      
      .onReceive(update) { newValue in
        if case .route(.main) = newValue {
          router.backToRoot()
          router.presentMain()
        }
      }
    }
  }
}

enum Update {
  case stub
  case example
  case route(Route)
}

enum Route: Hashable {
  case loading
  case main
}


final class Router: ObservableObject {
  static let shared = Router()
  
  @Published var path: [Route] = [.loading]
  
  //  func showProduct(product: Product) {
  //    path.append(.product(product))
  //  }
  
  func presentMain() {
    path.append(.main)
  }
  
  func showAddress() {
    //    path.append(.address)
  }
  
  func showOrderConfirmation() {
    //    path.append(.orderConfirmation)
  }
  
  func backToRoot() {
    path.removeAll()
  }
  
  func back() {
    path.removeLast()
  }
}
