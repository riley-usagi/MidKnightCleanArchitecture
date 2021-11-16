import SwiftUI

struct TargetsScreen: View {
  
  @Environment(\.container) var container: Container
  
  @State var targets: Loadable<LazyList<Target>>
  
  @State var newTargetScreenStatus: Bool = false
  
  init(targets: Loadable<LazyList<Target>> = .notRequested) {
    self._targets = .init(initialValue: targets)
  }
  
  var body: some View {
    content
      .sheet(isPresented: $newTargetScreenStatus, onDismiss: nil) {
        NewTargetScreen($targets)
          .inject(container)
          .background(BackgroundClearView())
      }
  }
}

extension TargetsScreen {
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

extension TargetsScreen {
  private var notRequestedView: some View {
    Text("")
      .onAppear {
        container.interactors.targetsInteractor.loadTargets($targets)
      }
  }
}

struct BackgroundClearView: UIViewRepresentable {
  func makeUIView(context: Context) -> UIView {
    let view = UIView()
    
    DispatchQueue.main.async {
      view.superview?.superview?.backgroundColor = .gray.withAlphaComponent(0.95)
    }
    
    return view
  }
  
  func updateUIView(_ uiView: UIView, context: Context) {}
}
