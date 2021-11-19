import Combine
import SwiftUI

protocol SettingsInteractor {
  func loadTotalCash(_ totalCash: LoadableSubject<Int>)
  func loadPayDay(_ payDay: LoadableSubject<Date>)
  func updatePayDay(_ newPayDay: Date)
  func numPadTapped(_ button: NumPadButton, _ totalCash: LoadableSubject<Int>, _ label: Int)
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
    
    
    appState[\.userData.todayCash] = appState[\.userData.totalCash] / Date.daysBetweenPlusOne(Date(), appState[\.userData.payDay])
  }
  
  func updatePayDay(_ newPayDay: Date) {
    appState[\.userData].payDay = newPayDay
  }
  
  func numPadTapped(_ button: NumPadButton, _ totalCash: LoadableSubject<Int>, _ label: Int) {
    
    var calculatedValue = String(label)
    
    switch button {

    case .zero:
      
      if calculatedValue == "0" {
        break
      } else {
        let calculatedValue = calculatedValue + "0"
        
        Just<Int>
          .withErrorType(Int(calculatedValue)!, Error.self)
          .sinkToLoadable { loadedCalculatedValuseAsInt in
            totalCash.wrappedValue = loadedCalculatedValuseAsInt
          }
          .store(in: cancelBag)
      }
      
    case .clear:
      
      var newCalculatedValue: String = ""
      
      if Int(calculatedValue)! <= 0 {
        newCalculatedValue = "0"
      } else {
        if calculatedValue.count > 1 {
          newCalculatedValue = String(calculatedValue.dropLast())
        } else {
          newCalculatedValue = "0"
        }
      }
      
      Just<Int>
        .withErrorType(Int(newCalculatedValue)!, Error.self)
        .sinkToLoadable { loadedCalculatedValuseAsInt in
          totalCash.wrappedValue = loadedCalculatedValuseAsInt
        }
        .store(in: cancelBag)
      
    case .enter:
      
      
      appState[\.userData.totalCash] = Int(calculatedValue)!
      
      // Перерасчёт количества денег на день
      appState[\.userData.todayCash] =
      Int(calculatedValue)! / Date.daysBetweenPlusOne(Date(), appState[\.userData.payDay])
      
      
      
    case .emptyZeroLeft, .emptyZeroRight, .emptyEnter:
      break
      
    default:
      
      let number = button.rawValue
      
      if calculatedValue == "0" {
        calculatedValue = number
      } else {
        calculatedValue += number
      }
      
      Just<Int>
        .withErrorType(Int(calculatedValue)!, Error.self)
        .sinkToLoadable { loadedCalculatedValuseAsInt in
          totalCash.wrappedValue = loadedCalculatedValuseAsInt
        }
        .store(in: cancelBag)
    }
  }
}

struct StubSettingsInteractor: SettingsInteractor {
  func loadTotalCash(_ totalCash: LoadableSubject<Int>) {}
  func loadPayDay(_ payDay: LoadableSubject<Date>) {}
  func updatePayDay(_ newPayDay: Date) {}
  func numPadTapped(_ button: NumPadButton, _ totalCash: LoadableSubject<Int>, _ label: Int) {}
}
