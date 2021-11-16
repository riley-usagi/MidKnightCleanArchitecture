import CoreData
import Foundation

extension TargetModelObject {
  static func all() -> NSFetchRequest<TargetModelObject> {
    
    let request = newFetchRequest()
    
    request.fetchBatchSize = 10
    
    return request
  }
  
  static func oneTarget(by id: String) -> NSFetchRequest<TargetModelObject> {
    
    let request = newFetchRequest()
    
    let predicate = NSPredicate(format: "id == %@", id)
    
    request.predicate = predicate
    
    request.fetchLimit = 1
    
    return request
    
  }
}
