import CoreData
import Foundation

struct Target: Identifiable {
  var id = UUID().uuidString
  var name: String
  var currentAmount: Int32
  var totalAmount: Int32
}


extension Target {
  
  init?(managedObject: TargetModelObject) {
    
    self.init(
      name: managedObject.name,
      currentAmount: managedObject.currentAmount,
      totalAmount: managedObject.totalAmount
    )
  }
  
  @discardableResult
  func modelToObjectWithin(_ context: NSManagedObjectContext) -> TargetModelObject? {
    guard let target = TargetModelObject.insertNew(in: context) else { return nil }
    
    target.name           = name
    target.currentAmount  = currentAmount
    target.totalAmount    = totalAmount
    
    return target
  }
}
