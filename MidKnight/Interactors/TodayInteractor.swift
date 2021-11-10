import Combine
import SwiftUI

protocol TodayInteractor {
  func loadTodayCash(_ todayCash: LoadableSubject<Int>)
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
}

struct StubTodayInteractor: TodayInteractor {
  func loadTodayCash(_ todayCash: LoadableSubject<Int>) {}
}
