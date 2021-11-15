import SwiftUI

struct NewDayScreen: View {
  
  @Environment(\.container) var container: Container
  
  @State private var targets: Loadable<LazyList<Target>>
  
  init(_ targets: Loadable<LazyList<Target>> = .notRequested) {
    self._targets = .init(initialValue: targets)
  }
  
  var body: some View {
    content
  }
}

extension NewDayScreen {
  var content: some View {
    switch targets {
      
    case .notRequested:
      return AnyView(notRequestedView)
    case .isLoading:
      return AnyView(ProgressView())
    case let .loaded(targets):
      return AnyView(loadedView(targets))
    case .failed:
      return AnyView(Text("Failed"))
    }
  }
}

extension NewDayScreen {
  private var notRequestedView: some View {
    Text("")
      .onAppear {
        container.interactors.targetsInteractor.loadTargets($targets)
      }
  }
}
