import SwiftUI

struct LoadingScreen: View {
  
  var body: some View {
    Button {
      update.send(.route(.main))
    } label: {
      Text("To main")
        .font(.largeTitle)
    }

  }
}
