import SwiftyUserDefaults
import SwiftUI

enum CalcButton: String {
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
  case clear  = "AC"
  case dot    = "."
  case enter  = "OK"
  
  var buttnColor: Color {
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

struct TodayScreen: View {
  
  @Environment(\.container) var container: Container
  
  @State private var todayCash = Defaults[\.todayCash]
  
  let buttons: [[CalcButton]] = [
    [.seven, .eight, .nine, .clear],
    [.four, .five, .six],
    [.one, .two, .three],
    [.zero, .dot, .enter]
  ]
  
  var body: some View {
    
    ZStack {
      
      VStack(spacing: 0) {
        
        HStack {
          Text("\(todayCash ?? 7) на сегодня")
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
        
        TextField("For today", value: $todayCash, formatter: NumberFormatter(), prompt: nil)
          .onSubmit {
            Defaults[\.todayCash] = todayCash
          }
          .keyboardType(.numberPad)
          .padding()
        
        Divider()
        
        VStack {
          HStack {
            Text("0")
              .bold()
              .font(.system(size: 52))
              .foregroundColor(.black)
            
            Spacer()
          }
          .padding()
          
          Spacer()
          
          ForEach(buttons, id: \.self) { row in
            
            HStack(spacing: 12) {
              ForEach(row, id: \.self) { item in
                Button {
                  
                } label: {
                  Text(item.rawValue)
                    .font(.system(size: 32))
                    .frame(
                      width: self.buttonWidth(item: item),
                      height: self.buttonHeight()
                    )
                    .background(item.buttnColor)
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
  
  func buttonWidth(item: CalcButton) -> CGFloat {
    return (UIScreen.main.bounds.width - (5*12)) / 4
  }
  
  func buttonHeight() -> CGFloat {
    return (UIScreen.main.bounds.width - (5*12)) / 4
  }
  
}
