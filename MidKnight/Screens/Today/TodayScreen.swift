import SwiftyUserDefaults
import SwiftUI

struct TodayScreen: View {
  var body: some View {
    VStack {
      Text("\(Defaults[\.todayCash]) на сегодня")
        .font(.largeTitle)
        .padding()
      
      Text("До \(Defaults[\.payDay])")
    }
  }
}
