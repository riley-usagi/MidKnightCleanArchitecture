import SwiftUI

extension TodayScreen {
  
  func loadedView(_ todayCash: Int) -> some View {
    ZStack {
      Color.black
        .edgesIgnoringSafeArea(.all)
      
      VStack(spacing: 0) {
        
        HStack {
          Text("\(todayCash) на сегодня")
            .font(.largeTitle)
            .foregroundColor(.white)
          
          Spacer()
          
          Button {
            container.appState.value.currentPage = .settings
          } label: {
            Image(systemName: "gearshape.fill")
              .resizable()
              .frame(width: 30, height: 30)
              .foregroundColor(.white)
          }
          .buttonStyle(DefaultButtonStyle())
          
        }
        .padding()
        
        Divider().background(Color.white)
          
        VStack {
          HStack {
            Text(calculatedValue)
              .bold()
              .font(.system(size: 72))
              .foregroundColor(.white)
            
            Spacer()
          }
          .padding()
          
          Spacer()
          
          Text("Здесь я предлагаю добавить умные советы по экономии денег. Записать 10 советов и включить их рандомное появление при переходе на экран.")
            .font(.system(size: 20))
            .foregroundColor(.white)
          
          Divider().background(Color.white)
          
          ForEach(buttons, id: \.self) { row in
            
            HStack(spacing: 12) {
              ForEach(row, id: \.self) { item in
                Button {
                  self.didTap(button: item)
                } label: {
                  Text(item.rawValue)
                    .font(.system(size: 32))
                    .frame(
                      width: self.buttonWidth(item: item),
                      height: self.buttonHeight()
                    )
                    .background(item.buttonColor)
                    .foregroundColor(.white)
                    .cornerRadius(self.buttonWidth(item: item) / 2)
                }
              }
            }
          }
        }
        .padding(.bottom, 3)
      }
      .padding(.horizontal, 30)
    }
  }
}

enum CalculatorButton: String {
  case one    = "1"
  case two    = "2"
  case three  = "3"
  case four   = "4"
  case five   = "5"
  case six    = "6"
  case seven  = "7"
  case eight  = "8"
  case nine   = "9"
  case zero   = "0"
  case clear  = "C"
  case enter  = "OK"
  
  var buttonColor: Color {
    switch self {
    case .clear:
      return .red
    case .enter:
      return .orange
    case .one, .two, .three, .four, .five, .six, .seven, .eight, .nine, .zero:
      return Color(.lightGray)
    }
  }
}

extension TodayScreen {
  func didTap(button: CalculatorButton) {
    switch button {
    case .clear:
      calculatedValue = String(calculatedValue.dropLast())
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
    return (UIScreen.main.bounds.width - (5*12)) / 4
  }
  
  func buttonHeight() -> CGFloat {
    return (UIScreen.main.bounds.width - (5*12)) / 4
  }
}
