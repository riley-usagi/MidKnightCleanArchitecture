import Combine
import SwiftUI

struct TodayScreen: View {
  
  @Environment(\.container) var container: Container
  
  @State private var todayCashLabel: Loadable<String>
  
  @State private var spendedCash: String = "0"
  
  @State private var todayWarningLabel = "На сегодня"
  @State private var spendedWarningLabel = "Потратить"
  
  let buttons: [[NumPadButton]] = [
    [.seven, .eight, .nine, .clear],
    [.four, .five, .six, .emptyEnter],
    [.one, .two, .three, .enter],
    [.emptyZeroLeft, .zero, .emptyZeroRight, .emptyEnter]
  ]
  
  init(_ todayCashLabel: Loadable<String> = .notRequested) {
    self._todayCashLabel = .init(initialValue: todayCashLabel)
  }
  
  var body: some View {
    content
  }
}


// MARK: - Content

private extension TodayScreen {
  var content: some View {
    switch todayCashLabel {
      
    case .notRequested:
      return AnyView(notRequestedView)
    case .isLoading:
      return AnyView(ProgressView())
    case let .loaded(cashLabel):
      return AnyView(loadedView(cashLabel))
    case .failed:
      return AnyView(Text("Failed"))
    }
  }
}


// MARK: - Not requested

private extension TodayScreen {
  var notRequestedView: some View {
    Text("")
      .onAppear {
        container.interactors.todayInteractor.loadTodayLabelCash($todayCashLabel)
      }
  }
}


// MARK: - Loaded view

private extension TodayScreen {
  func loadedView( _ cashLabel: String) -> some View {
    
    VStack(spacing: 0) {
      
      
      // MARK: - Menu
      
      HStack(spacing: 0) {
        
        Button {
          container.appState[\.currentPage] = .targets
        } label: {
          HStack {
            Image(systemName: "target")
            Text("Цели")
          }
          .font(.title3.bold())
        }
        
        Spacer()
        
        Button {
          container.appState[\.currentPage] = .settings
        } label: {
          HStack {
            Text("Настройки")
            Image(systemName: "gear")
          }
          .font(.title3.bold())
        }
      }
      .foregroundColor(.white)
      .padding()
      .padding(.horizontal)
      
      
      // MARK: - Today cash
      
      CustomStackView {
        Label {
          Text(todayWarningLabel)
        } icon: {
          Image(systemName: "rublesign.circle")
        }
        
      } contentView: {
        HStack(spacing: 0) {
          Text(cashLabel + " ₽")
            .font(.system(size: 54).bold())
          
          Spacer()
        }
      }
      .padding(.horizontal)
      
      
      // MARK: - Spended value
      
      CustomStackView {
        Label {
          Text(spendedWarningLabel)
        } icon: {
          Image(systemName: "rublesign.circle")
        }
      } contentView: {
        HStack(spacing: 0) {
          Spacer()
          
          Text(spendedCash + " ₽")
            .font(.system(size: 34).bold())
        }
      }
      .padding(.horizontal)
      
      // MARK: - Spacer
      
      Spacer()
      
      
      // MARK: - NumPad
      
      VStack(spacing: 0) {
      
        ForEach(buttons, id: \.self) { row in
        
        HStack(spacing: 0) {
          ForEach(row, id: \.self) { button in
            Button {
              container.interactors.todayInteractor.numPadTapped(button, $todayCashLabel, cashLabel, $spendedCash, $todayWarningLabel, $spendedWarningLabel)
            } label: {
              Text(button.rawValue)
                .font(button.font)
              
                .frame(
                  width: self.buttonWidth(),
                  height: self.buttonHeight()
                )
                .foregroundColor(button.labelColor)
            }
            .background(button.buttonColor)
            .border(Color.gray.opacity(0.1), width: 0.5)
          }
        }
        .ignoresSafeArea()
      }
      }
      .frame(maxHeight: UIScreen.main.bounds.height / 2.5)
    }
  }
}


// MARK: - Helpers

private extension TodayScreen {
  func buttonWidth() -> CGFloat {
    return (UIScreen.main.bounds.width - (5)) / 4
  }
  
  func buttonHeight() -> CGFloat {
    return ((UIScreen.main.bounds.height / 2.5) / 4)
  }
}
