import SwiftUI

struct AppState: Equatable {
  
  static var lastVisit: Date
  = UserDefaults.standard.object(forKey: "lastVisit") as? Date ?? Date()
  
  
}
