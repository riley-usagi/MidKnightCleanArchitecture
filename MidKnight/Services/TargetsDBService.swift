import Combine
import CoreData
import SwiftUI

protocol TargetsDBService {
  func loadTargets() -> AnyPublisher<LazyList<Target>, Error>
  func loadTarget(by id: String) -> AnyPublisher<Target, Error>
  func createTarget(_ name: String, _ currentAmount: Int, _ totalAmount: Int) -> AnyPublisher<Void, Error>
  func removeTarget(_ id: String) -> AnyPublisher<Void, Error>
  func updateTarget(_ id: String, _ addedValue: Int) -> AnyPublisher<Void, Error>
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
  
  func loadTarget(by id: String) -> AnyPublisher<Target, Error> {
    
    let request = TargetModelObject.oneTarget(by: id)
    
    return persistentStore
      .fetch(request) { fetchedTarget in
        Target(managedObject: fetchedTarget)
      }
      .map { $0.first! }
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
  
  func removeTarget(_ id: String) -> AnyPublisher<Void, Error> {
    
    let request = TargetModelObject.oneTarget(by: id)
    
    return persistentStore
      .delete(request)
      .eraseToAnyPublisher()
  }
  
  func updateTarget(_ id: String, _ addedValue: Int) -> AnyPublisher<Void, Error> {
    
    let request = TargetModelObject.oneTarget(by: id)
    
    return persistentStore
      .fetch(request) { fetchedTarget in
        Target(managedObject: fetchedTarget)
      }
      .map { $0.first! }
      .flatMap { target -> AnyPublisher<Void, Error> in
        return persistentStore
          .update {context in
            let updatedTarget = Target(name: target.name, currentAmount: target.currentAmount, totalAmount: target.totalAmount)
            
            updatedTarget.store(context)
          }
      }
      .eraseToAnyPublisher()
    
  }
}
