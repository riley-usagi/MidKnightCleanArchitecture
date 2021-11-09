import SwiftUI

struct AppState: Equatable {
  var currentPage: Container.Routes = .loading
}


// Чтение данных о дате из UserDefaults
////read
//let date = UserDefaults.standard.object(forKey: key) as! Date
//let df = DateFormatter()
//df.dateFormat = "dd/MM/yyyy HH:mm"
//print(df.string(from: date))
