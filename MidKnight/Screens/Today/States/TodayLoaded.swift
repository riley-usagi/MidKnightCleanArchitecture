import SwiftUI

extension TodayScreen {
  
  func loadedView(_ todayCash: Int) -> some View {
    
    VStack(spacing: 0) {
      
      CustomStackView {
        Label {
          Text("На сегодня")
            .foregroundColor(.white)
        } icon: {
          Image(systemName: "rublesign.circle")
        }
        .foregroundColor(.white)
      } contentView: {
        HStack(spacing: 0) {
          Text(String(todayCash) + " ₽")
            .font(.title.bold())
            .font(.system(size: 24))
            .foregroundColor(.white)
          
          Spacer()
        }
      }
      .padding(.top)
      
      
      CustomStackView {
        Label {
          Text("Потратить")
            .foregroundColor(.white)
        } icon: {
          Image(systemName: "rublesign.circle")
        }
        .foregroundColor(.white)
        
      } contentView: {
        HStack(spacing: 0) {
          Text(calculatedValue + " ₽")
            .bold()
            .font(.system(size: 72))
            .foregroundColor(.white)
          
          Spacer()
        }
      }
      .padding(.top)
      
      Spacer()
      
      
      // MARK: - Calculator
      
      ForEach(buttons, id: \.self) { row in
        
        HStack(spacing: 0) {
          ForEach(row, id: \.self) { item in
            Button {
              self.didTap(button: item)
            } label: {
              Text(item.rawValue)
                .font(.title3.bold())
                .frame(
                  width: self.buttonWidth(item: item),
                  height: self.buttonHeight()
                )
                .background(item.buttonColor)
                .foregroundColor(.black.opacity(0.7))
            }
            .border(Color.gray.opacity(0.1), width: 0.5)
          }
        }
        .ignoresSafeArea()
      }
      
    }
    .padding()
  }
}

enum CalculatorButton: String {
  case one        = "1"
  case two        = "2"
  case three      = "3"
  case four       = "4"
  case five       = "5"
  case six        = "6"
  case seven      = "7"
  case eight      = "8"
  case nine       = "9"
  case zero       = "0"
  case clear      = "C"
  case enter      = "OK"
  case emptyZero  = ""
  case emptyEnter = " "
  
  var buttonColor: Color {
    switch self {
    case .clear:
      return .gray
    case .enter, .emptyEnter:
      return .orange
    case .one, .two, .three, .four, .five, .six, .seven, .eight, .nine, .zero, .emptyZero:
      return Color(.white)
    }
  }
}

extension TodayScreen {
  func didTap(button: CalculatorButton) {
    switch button {
    case .clear:
      if calculatedValue.count == 1 {
        calculatedValue = "0"
      } else {
        calculatedValue = String(calculatedValue.dropLast())
      }
    case .enter:
      container.interactors.todayInteractor.updateCash($calculatedValue)
      self.calculatedValue = "0"
    default:
      let number = button.rawValue
      if self.calculatedValue == "0" {
        calculatedValue = number
      }
      else {
        self.calculatedValue = "\(self.calculatedValue)\(number)"
      }
    }
  }
  
  func buttonWidth(item: CalculatorButton) -> CGFloat {
    return (UIScreen.main.bounds.width - (5)) / 4
  }
  
  func buttonHeight() -> CGFloat {
    return (UIScreen.main.bounds.width - (5*12)) / 4
  }
}
