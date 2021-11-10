import SwiftUI

extension TodayScreen {
  
  func loadedView(_ todayCash: Int) -> some View {
    ZStack {
      
      VStack(spacing: 0) {
        
        HStack {
          Text("\(todayCash) на сегодня")
            .font(.largeTitle)
          
          Spacer()
          
          Button {
            container.appState.value.currentPage = .settings
          } label: {
            Image(systemName: "gearshape.fill")
              .resizable()
              .frame(width: 30, height: 30)
              .foregroundColor(.black)
          }
          .buttonStyle(DefaultButtonStyle())
          
        }
        .padding()
        
        Divider()
        
        //        TextField("For today", text: $calculatedValue, prompt: Text(""))
        //          .disabled(true)
        //          .keyboardType(.numberPad)
        //          .padding()
        //
        //        Divider()
        
        VStack {
          HStack {
            Text(calculatedValue)
              .bold()
              .font(.system(size: 72))
              .foregroundColor(.black)
            
            Spacer()
          }
          .padding()
          
          Spacer()
          
          
          ForEach(buttons, id: \.self) { row in
            
            HStack(spacing: 12) {
              ForEach(row, id: \.self) { item in
                Button {
                  self.didTap(button: item)
                  #warning("container")
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
  case dot    = "."
  case enter  = "OK"
  
  var buttonColor: Color {
    switch self {
    case .clear:
      return .red
    case .enter:
      return .orange
    case .one, .two, .three, .four, .five, .six, .seven, .eight, .nine, .zero, .dot:
      return Color(.lightGray)
    }
  }
}

extension TodayScreen {
  func didTap(button: CalculatorButton) {
    switch button {
    case .clear:
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
    if item == .enter {
      return ((UIScreen.main.bounds.width - (4*12)) / 4) * 2
    }
    if item == .zero {
      return ((UIScreen.main.bounds.width - (4*12)) / 4) * 2
    }
    if item == .clear {
      return ((UIScreen.main.bounds.width - (4*12)) / 4) * 2
    }
    return (UIScreen.main.bounds.width - (5*12)) / 4
  }
  
  func buttonHeight() -> CGFloat {
    return (UIScreen.main.bounds.width - (5*12)) / 4
  }
  
}
