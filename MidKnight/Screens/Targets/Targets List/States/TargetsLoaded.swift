import SwiftUI

extension TargetsScreen {
  func loadedView(_ targets: LazyList<Target>) -> some View {
    
    ZStack {
      
      ScrollView(.vertical, showsIndicators: false) {
        
        ForEach(targets) { target in
          CustomStackView {
            Label {
              Text(target.name)
            } icon: {
              Image(systemName: "star")
            }
            
          } contentView: {
            Text(String(target.currentAmount))
          }
        }
      }
      
      VStack {
        
        Spacer()
        
        Button {
          newTargetScreenStatus.toggle()
        } label: {
          Text("Новая цель")
        }
        .font(.title3.bold())
        .padding(.vertical, 22)
        .frame(maxWidth: .infinity)
        .background(
          .linearGradient(
            .init(colors: [
              Color(#colorLiteral(red: 0.4967626929, green: 0.1718424261, blue: 0.9535631537, alpha: 1)),
              Color(#colorLiteral(red: 0.2051824629, green: 0.2007484436, blue: 0.9180203676, alpha: 1))
            ]),
            startPoint: .leading, endPoint: .trailing
          ), in: RoundedRectangle(cornerRadius: 20)
        )
        .foregroundColor(.white)
        
      }
      
    }
    .padding()
    .padding(.top)
  }
}

