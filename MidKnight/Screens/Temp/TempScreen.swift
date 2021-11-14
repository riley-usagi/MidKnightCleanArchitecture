import SwiftUI

struct TempScreen: View {
  
  @Environment(\.container) var container: Container
  
  var screenSize: CGSize
  
  @State var offset: CGFloat = 0

  
  var items = [
    AnyView(SomeSheat()),
    AnyView(TodayScreen()),
    AnyView(SettingsScreen())
  ]
  
  var body: some View {
    
    VStack {
      
      OffsetPageTabView(offset: $offset) {
        
        HStack(spacing: 0) {
          
          
          ForEach(0...2, id: \.self) { index in
            
            VStack(spacing: 0) {
              items[index]
                .inject(container)
            }
            .padding()
            .frame(width: screenSize.width)
            
          }
        }
        
      }
      
      // MARK: - Pagination
      
      HStack(alignment: .bottom) {
        
        
        // MARK: - Indicators
        
        HStack(spacing: 12) {
          
          ForEach(items.indices, id: \.self) { index in
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
        
        Spacer()
      }
      .padding()
      .offset(y: -20)
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    .animation(.easeInOut, value: getIndex())
  }
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  func getIndicatorOffset() -> CGFloat {
    let progress = offset / screenSize.width
    
    // 12 scpacing
    // 7 circle size
    
    let maxWidth: CGFloat = 12 + 7
    
    return progress * maxWidth
  }
  
  func getIndex() -> Int {
    let progress = round(offset / screenSize.width)
    
    let index = min(Int(progress), items.count - 1)
    
    return index
  }
}
