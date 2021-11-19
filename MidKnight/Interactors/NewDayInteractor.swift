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
  
  let dbService: TargetsDBService
  
  let cancelBag = CancelBag()
  
  init(_ appState: Store<AppState>, _ dbService: TargetsDBService) {
    self.appState   = appState
    self.dbService  = dbService
  }
  
  func spentSomeMoney(_ spentType: SpentType) {
    switch spentType {
      
    case .divide:
      
      appState[\.userData.totalCash] = appState[\.userData.totalCash] + appState[\.userData.todayCash]
      
    case .today:
      
      // 1. Определяем новое количество денег на день, с учётом наступления нового дня
      let newTempCashForToday: Int = appState[\.userData.totalCash] / Date.daysBetweenPlusOne(Date(), appState[\.userData.payDay])
      
      // 2. Прибавляем к этому числу appState.userData.todayCash (который остался)
      let newCashForToday = appState[\.userData.todayCash] + newTempCashForToday
      
      // 3. Обновновляем appState.userData.todayCash
      appState[\.userData.todayCash] = newCashForToday
      
    case let .target(id):
      
      // 1. Найти объект Цели в базе по её ID
      dbService
        .loadTarget(by: id)
        .flatMap{ target -> AnyPublisher<Int, Error> in
          
          let howMuchIsLeftToSave: Int = Int(target.totalAmount - target.currentAmount)
          
          return Just<Int>
            .withErrorType(howMuchIsLeftToSave, Error.self)
        }
      
        .flatMap { howMuchIsLeftToSave -> AnyPublisher<Void, Error> in
          if appState[\.userData.todayCash] >= howMuchIsLeftToSave {
            
            // Завершаем накопление и обновляем - appState[\.userData.todayCash] (Delete)
            
            appState[\.userData.totalCash] = appState[\.userData.totalCash] / Date.daysBetweenPlusOne(Date(), appState[\.userData.payDay])
            
            return dbService
              .removeTarget(id)
            
          } else {
            
            // 1. Определяем новое количество денег на день, с учётом наступления нового дня
            let newCashForToday: Int = appState[\.userData.totalCash] / Date.daysBetweenPlusOne(Date(), appState[\.userData.payDay])

            // 2. Обновновляем appState.userData.todayCash
            appState[\.userData.todayCash] = newCashForToday

            return dbService
              .updateTarget(id, appState[\.userData.todayCash])
          }
        }
      
        .sink { _ in } receiveValue: { _ in }
        .store(in: cancelBag)
      
      break
    }
  }
}


struct StubNewDayInteractor: NewDayInteractor {
  func spentSomeMoney(_ spentType: SpentType) {}
}
