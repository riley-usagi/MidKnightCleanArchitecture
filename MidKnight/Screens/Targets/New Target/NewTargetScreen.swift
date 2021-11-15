import SwiftUI


struct NewTargetScreen: View {
  
  @Environment(\.container) var container: Container
  
  private enum NewTargetFormField: Int, Hashable {
    case name, currentAmount, totalAmount
  }
  
  @FocusState private var focusedField: NewTargetFormField?
  
  @State private var name: String = ""
  @State private var currentAmount: Int?
  @State private var totalAmount: Int?
  
  var body: some View {
    VStack {
      
      CustomStackView {
        Label {
          Text("На что копим:")
        } icon: {
          Image(systemName: "star")
        }
        
      } contentView: {
        TextField("Название цели", text: $name)
          .focused($focusedField, equals: .name)
      }
      
      CustomStackView {
        Label {
          Text("Хочу накопить:")
        } icon: {
          Image(systemName: "star")
        }
        
      } contentView: {
        TextField("Итоговая сумма", value: $totalAmount, formatter: NumberFormatter(), prompt: nil)
          .focused($focusedField, equals: .totalAmount)
          .foregroundColor(.gray)
      }
      
      CustomStackView {
        Label {
          Text("Начальная сумма:")
        } icon: {
          Image(systemName: "star")
        }
        
      } contentView: {
        TextField("Уже имею", value: $currentAmount, formatter: NumberFormatter(), prompt: nil)
          .focused($focusedField, equals: .currentAmount)
          .foregroundColor(.gray)
      }
      
      Spacer()
      
      Button {
        container.interactors.targetsInteractor.createtarget(name, currentAmount, totalAmount)
      } label: {
        Text("Создать")
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
    .padding()
    .padding(.top)
  }
}
