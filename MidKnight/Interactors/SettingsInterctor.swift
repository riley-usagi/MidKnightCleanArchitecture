import Combine
import SwiftUI

protocol SettingsInteractor {
  func loadTotalCash(_ totalCash: LoadableSubject<Int>)
  func loadPayDay(_ payDay: LoadableSubject<Date>)
  func updatePayDay(_ newPayDay: Date)
}

struct RealSettingsInteractor: SettingsInteractor {
  
  let appState: Store<AppState>
  
  let cancelBag = CancelBag()
  
  init(_ appState: Store<AppState>) {
    self.appState   = appState
  }
  
  func loadTotalCash(_ totalCash: LoadableSubject<Int>) {
    totalCash.wrappedValue.setIsLoading(cancelBag: cancelBag)
    
    Just<Int>
      .withErrorType(appState[\.userData].totalCash, Error.self)
      .sinkToLoadable { loadedTotalCashAsInt in
        totalCash.wrappedValue = loadedTotalCashAsInt
      }
      .store(in: cancelBag)
  }
  
  func loadPayDay(_ payDay: LoadableSubject<Date>) {
    payDay.wrappedValue.setIsLoading(cancelBag: cancelBag)
    
    Just<Date>
      .withErrorType(appState[\.userData].payDay, Error.self)
      .sinkToLoadable { loadedPayDayAsDate in
        payDay.wrappedValue = loadedPayDayAsDate
      }
      .store(in: cancelBag)
  }
  
  func updatePayDay(_ newPayDay: Date) {
    
    appState[\.userData].payDay = newPayDay
    
//    appState[\.userData].todayCash -= Int(calculatedValue.wrappedValue)!
//    appState[\.userData].totalCash -= Int(calculatedValue.wrappedValue)!
  }
}

struct StubSettingsInteractor: SettingsInteractor {
  func loadTotalCash(_ totalCash: LoadableSubject<Int>) {}
  func loadPayDay(_ payDay: LoadableSubject<Date>) {}
  func updatePayDay(_ newPayDay: Date) {}
}
