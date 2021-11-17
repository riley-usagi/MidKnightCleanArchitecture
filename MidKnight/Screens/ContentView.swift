import Combine
import SwiftUI

struct ContentView: View {
  
  var screenSize: CGSize
  
  private let container: Container
  
  @State var offset: CGFloat = 0
  
  @State var newDayStatus: Bool = false
  
  var screens = [
//    AnyView(TodayScreen()),
    AnyView(TargetsScreen()),
    AnyView(SettingsScreen())
  ]
  
  init(_ container: Container, _ screenSize: CGSize) {
    self.container = container
    self.screenSize = screenSize
  }
  
  var body: some View {
    
    ZStack {
      
      BackgroundView()
      
      // MARK: - Content
      
      OffsetPageTabView(offset: $offset) {

        HStack(spacing: 0) {

          ForEach(0...1, id: \.self) { index in

            VStack(spacing: 0) {
              screens[index]
                .inject(container)
            }
            .frame(width: screenSize.width)
          }
        }

      }
      
      
      // MARK: - Pagination
      
      VStack(spacing: 0) {

        HStack {

          HStack(spacing: 12) {

            ForEach(screens.indices, id: \.self) { index in
              Capsule()
                .fill(.white)
                .frame(width: getIndex() == index ? 20 : 7, height: 7)

            }

          }
          .overlay(

            Capsule()
              .fill(.white)
              .frame(width: 20, height: 7)
              .offset(x: getIndicatorOffset())

            , alignment: .leading
          )
          .offset(x: 10, y: -15)
        }
        .padding()
        .offset(y: 60)

        Spacer()
      }
    }
    .ignoresSafeArea()
    .sheet(isPresented: $newDayStatus, onDismiss: nil) {
      NewDayScreen()
        .background(BackgroundClearView())
//        .interactiveDismissDisabled(true)
        .inject(container)
    }
  }
}


// MARK: - Helpers

extension ContentView {
  func getIndicatorOffset() -> CGFloat {
    let progress = offset / screenSize.width
    
    let maxWidth: CGFloat = 12 + 7
    
    return progress * maxWidth
  }
  
  func getIndex() -> Int {
    let progress = round(offset / screenSize.width)
    
    let index = min(Int(progress), screens.count - 1)
    
    return index
  }
}
