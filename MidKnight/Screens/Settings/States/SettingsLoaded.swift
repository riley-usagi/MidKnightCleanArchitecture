import SwiftUI

extension SettingsScreen {
  func loadedView(_ totalCash: Int) -> some View {
    
    VStack {
      
      VStack(spacing: 8) {
        
        CustomStackView {
          Label {
            Text("Всего")
          } icon: {
            Image(systemName: "rublesign.circle")
          }
          .foregroundColor(.white)
          
        } contentView: {
          
          VStack(spacing: 0) {
            HStack {
              Text(String(totalCash))
                .bold()
                .font(.system(size: 72))
                .foregroundColor(.white)
            }
            
            Text("\(totalCash / Date.daysBetweenPlusOne(Date(), settingsScreenPayDay)) в день")
              .font(.callout.bold())
              .foregroundColor(.white)
              .padding(.bottom)
          }
          .padding()
        }
        
        Spacer()
        
        CustomStackView {
          Label {
            Text("Дата пополнения")
          } icon: {
            Image(systemName: "calendar")
          }
          .foregroundColor(.white)
        } contentView: {
          PayDayPickerView(payDay: .notRequested, totalCash: totalCash)
        }
        
        Spacer()
        
        CustomStackView {
          Label {
            Text("О приложении")
          } icon: {
            Image(systemName: "questionmark.circle")
          }
          .foregroundColor(.white)
        } contentView: {
          VStack(spacing: 0) {
            HStack {
              Text("Приложение помогает копить деньги")
                .font(.title2.bold())
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
            }
            
          }
          .padding()
        }

      }
    }
    .padding()
    .padding(.top)
//    .padding(.horizontal)
  }
}
