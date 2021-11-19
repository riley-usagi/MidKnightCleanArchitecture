import CoreData
import Foundation

@objc(TargetModelObject)
public class TargetModelObject: NSManagedObject, Identifiable, ManagedEntity {
  @NSManaged public var id: String
  @NSManaged public var name: String
  @NSManaged public var currentAmount: Int32
  @NSManaged public var totalAmount: Int32
}
