import SwiftyUserDefaults
import SwiftUI

struct SettingsScreen: View {
  
  @State private var payDay = Defaults[\.payDay]
  
  let dateFormatter = DateFormatter()
  
  let arrayOfFourthDays: [Date] = Date.arrayOfFourthDays()
  
  var body: some View {
    
    VStack(spacing: 0) {
      
      Menu("\(dateFormatter.string(from: payDay))") {
        
        ForEach(Array(Date.arrayOfFourthDays().enumerated().sorted(by: >)), id: \.element) { index, item in
          
          Button {
            payDay = arrayOfFourthDays[index]
          } label: {
            Text(
              "\(self.dateFormatter.string(from: self.arrayOfFourthDays[index])) - \(index + 1) \(Date.dayDeclension(dayNumber: index + 1))"
            )
          }
        }
      }
    }
  }
  
  init() {
    dateFormatter.dateFormat  = "d MMM"
    dateFormatter.locale      = Locale(identifier: "ru_RU")
  }
}
