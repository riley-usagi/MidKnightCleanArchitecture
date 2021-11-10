import Combine
import SwiftUI

protocol TodayInteractor {
  func loadTodayCash(_ todayCash: LoadableSubject<Int>)
  func updateCash(_ calculatedValue: Binding<String>)
}

struct RealTodayInteractor: TodayInteractor {
  
  let appState: Store<AppState>
  
  let cancelBag = CancelBag()
  
  init(_ appState: Store<AppState>) {
    self.appState   = appState
  }
  
  func loadTodayCash(_ todayCash: LoadableSubject<Int>) {
    todayCash.wrappedValue.setIsLoading(cancelBag: cancelBag)
    
    Just<Int>
      .withErrorType(appState[\.userData].todayCash, Error.self)
      .sinkToLoadable { loadedTodayCashAsInt in
        todayCash.wrappedValue = loadedTodayCashAsInt
      }
      .store(in: cancelBag)
  }
  
  func updateCash(_ calculatedValue: Binding<String>) {
    #warning("Fix")
    appState[\.userData].todayCash -= Int(calculatedValue.wrappedValue)!
    appState[\.userData].totalCash -= Int(calculatedValue.wrappedValue)!
  }
}

struct StubTodayInteractor: TodayInteractor {
  func loadTodayCash(_ todayCash: LoadableSubject<Int>) {}
  func updateCash(_ calculatedValue: Binding<String>) {}
}
