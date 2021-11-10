import SwiftUI

extension SettingsScreen {
  func loadedView(_ totalCash: Int) -> some View {
    VStack {
      Text(String(totalCash))
      
      PayDayPickerView(payDay: .notRequested, totalCash: totalCash)
    }
  }
}
