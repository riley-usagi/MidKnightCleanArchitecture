import Combine
import SwiftUI

protocol TargetsInteractor {
  func loadTargets(_ targets: LoadableSubject<LazyList<Target>>)
  
  func createTarget(_ name: String, _ currentAmount: Int?, _ totalAmount: Int?, completion: @escaping (Result<Void, Error>) -> Void)
  
  func removeTarget(_ id: String)
}

struct RealTargetsInteractor: TargetsInteractor {
  
  let appState: Store<AppState>
  
  let dbService: TargetsDBService
  
  let cancelBag = CancelBag()
  
  init(_ appState: Store<AppState>, _ dbService: TargetsDBService) {
    self.appState   = appState
    self.dbService  = dbService
  }
  
  func loadTargets(_ targets: LoadableSubject<LazyList<Target>>) {
    
    targets.wrappedValue.setIsLoading(cancelBag: cancelBag)
    
    dbService
      .loadTargets()
      .sinkToLoadable { loadedTargets in
        targets.wrappedValue = loadedTargets
      }
      .store(in: cancelBag)
  }
  
  func createTarget(_ name: String, _ currentAmount: Int?, _ totalAmount: Int?, completion: @escaping (Result<Void, Error>) -> Void) {
    dbService
      .createTarget(name, currentAmount!, totalAmount!)
      .sinkToResult { _ in
        completion(.success(()))
      }
      .store(in: cancelBag)
  }
  
  func removeTarget(_ id: String) {
    dbService
      .removeTarget(id)
      .sinkToResult { _ in }
      .store(in: cancelBag)
  }
}

struct StubTargetsInteractor: TargetsInteractor {
  func loadTargets(_ targets: LoadableSubject<LazyList<Target>>) {}
  func createTarget(_ name: String, _ currentAmount: Int?, _ totalAmount: Int?, completion: @escaping (Result<Void, Error>) -> Void) {}
  
  func removeTarget(_ id: String) {}
}
