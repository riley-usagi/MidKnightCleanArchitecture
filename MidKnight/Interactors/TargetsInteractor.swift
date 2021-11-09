import Combine
import SwiftUI

protocol TargetsInteractor {
  func loadTargets(_ targets: LoadableSubject<LazyList<Target>>)
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
}

struct StubTargetsInteractor: TargetsInteractor {
  func loadTargets(_ targets: LoadableSubject<LazyList<Target>>) {}
}
