import Combine
import CoreData

protocol TargetsDBService {
  func loadTargets() -> AnyPublisher<LazyList<Target>, Error>
  func createTarget(_ name: String, _ currentAmount: Int, _ totalAmount: Int) -> AnyPublisher<Void, Error>
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
  
  func createTarget(_ name: String, _ currentAmount: Int, _ totalAmount: Int) -> AnyPublisher<Void, Error> {
    
    return persistentStore
      .update { context in
        
        let newTargetModelObject =
        Target(name: name, currentAmount: Int32(currentAmount), totalAmount: Int32(totalAmount))
        
        newTargetModelObject.store(context)
      }
      .eraseToAnyPublisher()
  }
}
