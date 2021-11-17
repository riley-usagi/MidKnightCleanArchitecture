import Combine
import SwiftUI

enum SpentType {
  case divide
  case today
  case target(id: String)
}

protocol NewDayInteractor {
  func spentSomeMoney(_ spentType: SpentType)
}

struct RealNewDayInteractor: NewDayInteractor {
  
  let appState: Store<AppState>
  
  let cancelBag = CancelBag()
  
  init(_ appState: Store<AppState>) {
    self.appState = appState
  }
  
  func spentSomeMoney(_ spentType: SpentType) {
    switch spentType {
    
    case .divide:
      print("")
    
    case .today:
      print("")
    
    case let .target(id):
      print(id)
    }
  }
}

struct StubNewDayInteractor: NewDayInteractor {
  func spentSomeMoney(_ spentType: SpentType) {}
}
