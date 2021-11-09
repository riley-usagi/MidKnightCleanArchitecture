import SwiftyUserDefaults
import SwiftUI

enum CalcButton: String {
  case one
  case two
  case three
  case four
  case five
  case six
  case seven
  case eight
  case nine
  case zero
  case clear
  case dot
  case enter
}

struct TodayScreen: View {
  
  @Environment(\.container) var container: Container
  
  @State private var todayCash = Defaults[\.todayCash]
  
  let buttons: [[CalcButton]] = [
    [.seven, .eight, .nine]
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
        
        HStack {
          Text("0")
            .bold()
            .font(.system(size: 52))
            .foregroundColor(.black)
            
          Spacer()
        }
        .padding()
        
        ForEach(buttons, id: \.self) { row in
          ForEach(row, id: \.self) { item in
            Button {
              
            } label: {
              Text(item.rawValue)
                .frame(width: 70, height: 70)
                .background(Color.orange)
                .foregroundColor(.white)
                .cornerRadius(35)
            }

          }
        }
        
        
        
        
        
        
        
      }
      .padding(.horizontal, 30)
    }
  }
}
