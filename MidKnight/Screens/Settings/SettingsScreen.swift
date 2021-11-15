import Combine
import SwiftUI

struct SettingsScreen: View {
  
  @Environment(\.container) var container: Container
  
  @State private var totalCash: Loadable<Int>
  
  @State var settingsScreenPayDay: Date = Date()
  
  var body: some View {
    content
      .onReceive(payDayUpdate) { newValue in
        settingsScreenPayDay = newValue
      }
  }
  
  init(_ totalCash: Loadable<Int> = .notRequested) {
    self._totalCash = .init(initialValue: totalCash)
  }
}

private extension SettingsScreen {
  var content: some View {
    switch totalCash {

    case .notRequested:
      return AnyView(notRequestedView)
    case .isLoading:
      return AnyView(ProgressView())
    case let .loaded(totalCash):
      return AnyView(loadedView(totalCash))
    case .failed:
      return AnyView(Text("Failed"))
    }
  }
}

private extension SettingsScreen {
  var notRequestedView: some View {
    Text("")
      .onAppear {
        container.interactors.settingsInteractor.loadTotalCash($totalCash)
      }
  }
}

extension SettingsScreen {
  var payDayUpdate: AnyPublisher<Date, Never> {
    container.appState.updates(for: \.userData.payDay)
  }
}
