import SwiftUI

extension SettingsScreen {
  func loadedView(_ totalCash: Int) -> some View {
    
    VStack {
      
      VStack(alignment: .center, spacing: 5) {
        Text("Настройки")
          .font(.largeTitle.bold())
          .foregroundColor(.white)
          .shadow(radius: 5)
      }
      
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
      
      Spacer()
      
    }
    .padding(.top, 25)
    .padding([.horizontal, .bottom])
  }
}
