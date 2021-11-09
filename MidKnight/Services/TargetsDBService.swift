import Combine
import CoreData

protocol TargetsDBService {
  func loadTargets() -> AnyPublisher<LazyList<Target>, Error>
}

struct RealTargetsDBService: TargetsDBService {
  let persistentStore: PersistentStore
  
  init(_ persistentStore: PersistentStore) {
    self.persistentStore = persistentStore
  }
  
  func loadTargets() -> AnyPublisher<LazyList<Target>, Error> {
    
    let request = TargetModelObject.all()
    
    return persistentStore
      .fetch(request) { fetchedTargets in
        Target(managedObject: fetchedTargets)
      }
      .eraseToAnyPublisher()
  }
  
}
