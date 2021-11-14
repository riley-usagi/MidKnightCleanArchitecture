import SwiftUI

struct OffsetPageTabView<Content: View>: UIViewRepresentable {
  
  var content: Content
  @Binding var offset: CGFloat
  
  func makeCoordinator() -> Coordinator {
    return OffsetPageTabView.Coordinator(parent: self)
  }
  
  init(offset: Binding<CGFloat>, @ViewBuilder content: @escaping () -> Content) {
    self.content = content()
    self._offset = offset
  }
  
  func makeUIView(context: Context) -> UIScrollView {
    let scrollView = UIScrollView()
    
    let hostview = UIHostingController(rootView: content)
    hostview.view.translatesAutoresizingMaskIntoConstraints = false
    
    let constraints = [
      hostview.view.topAnchor.constraint(equalTo: scrollView.topAnchor),
      hostview.view.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
      hostview.view.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
      hostview.view.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
      
      // if using vertical, than dont use it
      hostview.view.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
    ]
    
    scrollView.addSubview(hostview.view)
    scrollView.addConstraints(constraints)
    
    scrollView.isPagingEnabled = true
    scrollView.showsVerticalScrollIndicator = false
    scrollView.showsHorizontalScrollIndicator = false
    
    scrollView.delegate = context.coordinator
    
    return scrollView
  }
  
  func updateUIView(_ uiView: UIScrollView, context: Context) {
    
  }
  
  class Coordinator: NSObject, UIScrollViewDelegate {
    
    var parent: OffsetPageTabView
    
    init(parent: OffsetPageTabView) {
      self.parent = parent
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
      let offset = scrollView.contentOffset.x
      
      parent.offset = offset
    }
  }
  
}
