import CoreData
import Foundation

extension TargetModelObject {
  static func all() -> NSFetchRequest<TargetModelObject> {
    
    let request = newFetchRequest()
    
    request.fetchBatchSize = 10
    
    return request
  }
}


