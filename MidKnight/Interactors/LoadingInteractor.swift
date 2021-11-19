import Combine
import SwiftUI

protocol LoadingInteractor {
  func checkThatNewDayHasCome()
}

struct RealLoadingInteractor: LoadingInteractor {
  
  let appState: Store<AppState>
  
  let cancelBag = CancelBag()
  
  init(_ appState: Store<AppState>) {
    self.appState = appState
  }
  
  func checkThatNewDayHasCome() {
    
    if Calendar.current.isDate(appState[\.userData.lastVisit], inSameDayAs: Date()) {
      appState[\.currentPage] = .today
    } else {
      appState[\.currentPage] = .newDay
    }
    
    appState[\.userData.lastVisit] = Date()
  }
}

struct StubLoadingInteractor: LoadingInteractor {
  func checkThatNewDayHasCome() {}
}
