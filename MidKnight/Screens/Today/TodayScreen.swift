import Combine
import SwiftUI

struct TodayScreen: View {
  
  @Environment(\.container) var container: Container
  
  @State private var todayCash: Loadable<Int>
  
  let buttons: [[CalculatorButton]] = [
    [.seven, .eight, .nine, .clear],
    [.four, .five, .six, .emptyEnter],
    [.one, .two, .three, .emptyEnter],
    [.emptyZero, .zero, .emptyZero, .enter]
  ]
  
  @State var calculatedValue: String = "0"
  
  init(todayCash: Loadable<Int> = .notRequested) {
    self._todayCash = .init(initialValue: todayCash)
  }
  
  var body: some View {
    content
      .edgesIgnoringSafeArea(.bottom)
      .onReceive(todayCashUpdate) { _ in
        DispatchQueue.main.async {
          withAnimation(.spring()) {
            container.interactors.todayInteractor.loadTodayCash($todayCash)
          }
        }
      }
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

private extension TodayScreen {
  
  var todayCashUpdate: AnyPublisher<Int, Never> {
    container.appState.updates(for: \.userData.todayCash)
  }
}
