import Combine
import SwiftUI

struct SettingsScreen: View {
  
  @Environment(\.container) var container: Container
  
  @State private var totalCash: Loadable<Int>
  
  @State var settingsScreenPayDay: Date = Date()
  
  let buttons: [[NumPadButton]] = [
    [.seven, .eight, .nine, .clear],
    [.four, .five, .six, .emptyEnter],
    [.one, .two, .three, .enter],
    [.emptyZeroLeft, .zero, .emptyZeroRight, .emptyEnter]
  ]
  
  var body: some View {
    content
      .onReceive(payDayUpdate) { newPayday in
        settingsScreenPayDay = newPayday
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


// MARK: - Not requested

private extension SettingsScreen {
  var notRequestedView: some View {
    Text("")
      .onAppear {
        container.interactors.settingsInteractor.loadTotalCash($totalCash)
      }
  }
}


// MARK: - Loaded


extension SettingsScreen {
  
  func loadedView(_ loadedTotalCash: Int) -> some View {
    
    VStack(spacing: 0) {
      
      HStack(spacing: 0) {
        
        Button {
          container.appState[\.currentPage] = .today
        } label: {
          HStack(spacing: 5) {
            Image(systemName: "arrow.left")
            Text("Назад")
          }
          .font(.title3.bold())
        }
        
        Spacer()
      }
      .foregroundColor(.white)
      .padding()
      .padding(.horizontal)
      
      CustomStackView {
        Label {
          Text("Всего:")
        } icon: {
          Image(systemName: "rublesign.circle")
        }
        
      } contentView: {
        
        VStack(spacing: 0) {
          
          HStack(spacing: 0) {
            Text(String(loadedTotalCash))
              .font(.system(size: 30).bold())
              .foregroundColor(.white)
          }
          
          Text("\(loadedTotalCash / Date.daysBetweenPlusOne(Date(), settingsScreenPayDay)) в день")
            .font(.callout.bold())
            .foregroundColor(.white)
        }
      }
      .padding(.horizontal)
      
      CustomStackView {
        Label {
          Text("Дата пополнения")
        } icon: {
          Image(systemName: "calendar")
        }
        .foregroundColor(.white)
      } contentView: {
        PayDayPickerView(payDay: .notRequested, totalCash: loadedTotalCash)
      }
      .padding(.horizontal)
      
      Spacer()
      
      
      // MARK: - NumPad
      
      VStack(spacing: 0) {
      
      ForEach(buttons, id: \.self) { row in
        
        HStack(spacing: 0) {
          ForEach(row, id: \.self) { button in
            
            Button {
              DispatchQueue.main.async {
                withAnimation(.spring()) {
                  container.interactors.settingsInteractor.numPadTapped(button, $totalCash, loadedTotalCash)
                }
              }
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


// MARK: - Updates

extension SettingsScreen {
  var payDayUpdate: AnyPublisher<Date, Never> {
    container.appState.updates(for: \.userData.payDay)
  }
}


// MARK: - Helpers

private extension SettingsScreen {
  func buttonWidth() -> CGFloat {
    return (UIScreen.main.bounds.width - (5)) / 4
  }
  
  func buttonHeight() -> CGFloat {
    return ((UIScreen.main.bounds.height / 2.5) / 4)
  }
}
