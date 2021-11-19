import SwiftUI

struct PayDayPickerView: View {
  
  @Environment(\.container) var container: Container
  
  @State private var payDay: Loadable<Date>
  
  let dateFormatter = DateFormatter()
  
  var totalCash: Int
  
  let arrayOfFourthDays: [Date] = Date.arrayOfFourthDays()
  
  init(payDay: Loadable<Date> = .notRequested, totalCash: Int = 0) {
    self._payDay    = .init(initialValue: payDay)
    self.totalCash  = totalCash
    dateFormatter.dateFormat  = "d MMMM"
    dateFormatter.locale      = Locale(identifier: "ru_RU")
  }
  
  var body: some View {
    content
  }
}

private extension PayDayPickerView {
  var content: some View {
    switch payDay {
      
    case .notRequested:
      return AnyView(notRequestedView)
    case .isLoading:
      return AnyView(ProgressView())
    case let .loaded(payDay):
      return AnyView(loadedView(payDay))
    case .failed:
      return AnyView(Text("Failed"))
    }
  }
}

private extension PayDayPickerView {
  var notRequestedView: some View {
    Text("")
      .onAppear {
        container.interactors.settingsInteractor.loadPayDay($payDay)
      }
  }
}

private extension PayDayPickerView {
  
  func loadedView( _ payDay: Date) -> some View {
    
    Menu("\(dateFormatter.string(from: payDay))") {
      
      ForEach(Array(Date.arrayOfFourthDays().enumerated().sorted(by: >)), id: \.element) { index, item in
        
        Button {
          
          container.interactors.settingsInteractor.updatePayDay(item)
          
          DispatchQueue.main.async {
            withAnimation(.spring()) {
              container.interactors.settingsInteractor.loadPayDay($payDay)
            }
          }
        } label: {
          HStack(spacing: 0) {
            Text(
              "\(self.dateFormatter.string(from: self.arrayOfFourthDays[index])) - \(index + 1) \(Date.dayDeclension(dayNumber: index + 1))"
            )
          }
        }
      }
    }
    .font(.title3.bold())
    .padding(.vertical, 22)
    .frame(maxWidth: .infinity)
    .background(
      .linearGradient(
        .init(colors: [
          Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)),
          Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1))
        ]),
        startPoint: .leading, endPoint: .trailing
      ), in: RoundedRectangle(cornerRadius: 20)
    )
    .foregroundColor(.white)
  }
}
