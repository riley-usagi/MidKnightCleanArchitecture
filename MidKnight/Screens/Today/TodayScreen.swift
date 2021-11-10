import SwiftyUserDefaults
import SwiftUI

struct TodayScreen: View {
  
  @Environment(\.container) var container: Container
  
  @State private var todayCash: Loadable<Int>
  
  let buttons: [[CalculatorButton]] = [
    [.six, .seven, .eight, .nine],
    [.two, .three, .four, .five],
    [.dot, .zero, .one],
    [.clear, .enter]
  ]
  
  @State var calculatedValue: String = "0"
  
  init(todayCash: Loadable<Int> = .notRequested) {
    self._todayCash = .init(initialValue: todayCash)
  }
  
  var body: some View {
    content
  }
}

private extension TodayScreen {
  var content: some View {
    switch todayCash {
      
    case .notRequested:
      return AnyView(notRequestedView)
    case .isLoading:
      return AnyView(ProgressView())
    case let .loaded(todayCash):
      return AnyView(loadedView(todayCash))
    case .failed:
      return AnyView(Text("Failed"))
    }
  }
}

private extension TodayScreen {
  var notRequestedView: some View {
    Text("")
      .onAppear {
        container.interactors.todayInteractor.loadTodayCash($todayCash)
      }
  }
}
