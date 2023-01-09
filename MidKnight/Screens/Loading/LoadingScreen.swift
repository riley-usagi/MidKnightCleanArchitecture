import SwiftUI

struct LoadingScreen: View {
  
  var body: some View {
    
    ProgressView()
    
      .navigationBarBackButtonHidden(true)
    
      .onAppear {
        if Calendar.current.isDate(AppState.lastVisit, inSameDayAs: Date()) {
          route.send(.home)
        } else {
          route.send(.newDay)
        }
        
        AppState.lastVisit = Date()
      }
  }
}
