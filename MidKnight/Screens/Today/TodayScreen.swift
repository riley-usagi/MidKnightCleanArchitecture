import SwiftyUserDefaults
import SwiftUI

struct TodayScreen: View {
  
  @Environment(\.container) var container: Container
  
  @State private var todayCash = Defaults[\.todayCash]
  
  var body: some View {
    VStack {
      Text("\(todayCash ?? 7) на сегодня")
        .font(.largeTitle)
        .padding()
      
      TextField("For today", value: $todayCash, formatter: NumberFormatter(), prompt: nil)
        .onSubmit {
          Defaults[\.todayCash] = todayCash
        }
        .keyboardType(.numberPad)
        .padding()
      
      
      Spacer()
      
      Button {
        container.appState.value.currentPage = .settings
      } label: {
        Text("To Settings")
      }
      .buttonStyle(DefaultButtonStyle())

    }
  }
}
