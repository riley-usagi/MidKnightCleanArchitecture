import SwiftUI

struct AppState: Equatable {
  var currentPage: Container.Routes = .loading
  
  var userData: UserData = UserData()
}

extension AppState {
  
  struct UserData: Equatable {
    
    var lastVisit: Date {
      didSet {
        UserDefaults.standard.set(lastVisit, forKey: "lastVisit")
      }
    }
    
    var totalCash: Int {
      didSet {
        UserDefaults.standard.set(totalCash, forKey: "totalCash")
      }
    }
    
    var payDay: Date {
      didSet {
        UserDefaults.standard.set(payDay, forKey: "payDay")
      }
    }
    
    var todayCash: Int {
      didSet {
        UserDefaults.standard.set(todayCash, forKey: "todayCash")
      }
    }
    
    init() {
      
      if (UserDefaults.standard.object(forKey: "lastVisit") == nil) {
        UserDefaults.standard.set(Date(), forKey: "lastVisit")
      }
      
      if (UserDefaults.standard.object(forKey: "totalCash") == nil) {
        UserDefaults.standard.set(21_000, forKey: "totalCash")
      }
      
      if (UserDefaults.standard.object(forKey: "payDay") == nil) {
        
        let fouthDaysForward = Calendar.current.date(byAdding: .day, value: 39, to: Date())!
        
        UserDefaults.standard.set(fouthDaysForward, forKey: "payDay")
      }
      
      if (UserDefaults.standard.object(forKey: "todayCash") == nil) {
        
        UserDefaults.standard.set(525, forKey: "todayCash")
      }
      
      self.lastVisit  = UserDefaults.standard.object(forKey: "lastVisit") as! Date
      self.totalCash  = UserDefaults.standard.object(forKey: "totalCash") as! Int
      self.payDay     = UserDefaults.standard.object(forKey: "payDay") as! Date
      self.todayCash  = UserDefaults.standard.object(forKey: "todayCash") as! Int
      
//            clearAllUserDefaultsData()
    }
    
    /// Зачиска UserDefaults для разработки
    func clearAllUserDefaultsData() {
      let domain = Bundle.main.bundleIdentifier!
      UserDefaults.standard.removePersistentDomain(forName: domain)
      UserDefaults.standard.synchronize()
      // print(Array(UserDefaults.standard.dictionaryRepresentation().keys).count)
    }
  }
}
