import Combine
import SwiftUI

protocol TodayInteractor {
  func loadTodayLabelCash(_ todayCashLabel: LoadableSubject<String>)
  func numPadTapped(
    _ button: NumPadButton, _ todayCashLabel: LoadableSubject<String>, _ cashLabel: String,
    _ spendedCash: Binding<String>, _ todayWarning: Binding<String>, _ spendedWarning: Binding<String>
  )
}

struct RealTodayInteractor: TodayInteractor {
  let appState: Store<AppState>
  
  let cancelBag = CancelBag()
  
  init(_ appState: Store<AppState>) {
    self.appState = appState
  }
  
  func loadTodayLabelCash(_ todayCashLabel: LoadableSubject<String>) {
    todayCashLabel.wrappedValue.setIsLoading(cancelBag: cancelBag)
    
    Just<String>
      .withErrorType(String(appState[\.userData.todayCash]), Error.self)
      .sinkToLoadable { loadedTodayCashAsString in
        todayCashLabel.wrappedValue = loadedTodayCashAsString
      }
      .store(in: cancelBag)
  }
  
  func numPadTapped(
    _ button: NumPadButton, _ todayCashLabel: LoadableSubject<String>, _ cashLabel: String,
    _ spendedCash: Binding<String>, _ todayWarning: Binding<String>, _ spendedWarning: Binding<String>
  ) {
    
    switch button {
      
      
      // MARK: - Clear
      
    case .clear:
      if spendedCash.wrappedValue.count == 1 {
        spendedCash.wrappedValue = "0"
      } else {
        spendedCash.wrappedValue = String(spendedCash.wrappedValue.dropLast())
      }
      

      // MARK: - Enter
      
    case .enter:
      
      // Change TodayCash
      if appState[\.userData.todayCash] >= Int(spendedCash.wrappedValue)! {
        appState[\.userData.todayCash] -= Int(spendedCash.wrappedValue)!
      } else {
        appState[\.userData.todayCash] = 0
      }
      
      // Change TotalCash
      if appState[\.userData.totalCash] >= Int(spendedCash.wrappedValue)! {
        appState[\.userData.totalCash] -= Int(spendedCash.wrappedValue)!
      } else {
        appState[\.userData.totalCash] = 0
      }
      
      spendedCash.wrappedValue = "0"
      
    case .emptyZeroLeft, .emptyZeroRight, .emptyEnter:
      break
      
      
      // MARK: - Zero
      
    case .zero:
      if spendedCash.wrappedValue == "0" {
        break
      } else {
        spendedCash.wrappedValue += "0"
      }
      
      
      // MARK: - Other buttons
    default:
      let number = button.rawValue
      
      if spendedCash.wrappedValue == "0" {
        spendedCash.wrappedValue = number
      } else {
        spendedCash.wrappedValue += number
      }
    }
    
    
    
    // MARK: - Update UserDefaults values
    var calculatedValue: String = ""
    
    if Int(exactly: appState[\.userData.todayCash])! - Int(spendedCash.wrappedValue)! > 0 {
      calculatedValue = String(Int(exactly: appState[\.userData.todayCash])! - Int(spendedCash.wrappedValue)!)
    } else {
      calculatedValue = "0"
    }
    
    Just<String>
      .withErrorType(calculatedValue, Error.self)
      .sinkToLoadable { calculatedValue in
        todayCashLabel.wrappedValue = calculatedValue
      }
      .store(in: cancelBag)
    
    
    if Int(spendedCash.wrappedValue)! > appState[\.userData.todayCash] {
      todayWarning.wrappedValue = "Превышаем дневной лимит!"
    } else {
      todayWarning.wrappedValue = "На сегодня"
    }
    
    if Int(spendedCash.wrappedValue)! >= appState[\.userData.totalCash] {
      spendedWarning.wrappedValue = "Деньги кончились"
    } else {
      spendedWarning.wrappedValue = "Потратить"
    }
  }
}

struct StubTodayInteractor: TodayInteractor {
  func loadTodayLabelCash(_ todayCash: LoadableSubject<String>) {}
  func numPadTapped(
    _ button: NumPadButton, _ todayCashLabel: LoadableSubject<String>, _ cashLabel: String,
    _ spendedCash: Binding<String>, _ todayWarning: Binding<String>, _ spendedWarning: Binding<String>
  ) {}
}
