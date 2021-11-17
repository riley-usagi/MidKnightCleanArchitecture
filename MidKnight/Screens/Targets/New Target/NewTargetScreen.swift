import SwiftUI


struct NewTargetScreen: View {
  
  @Environment(\.container) var container: Container
  
  private enum NewTargetFormField: Int, Hashable {
    case name, currentAmount, totalAmount
  }
  
  @Environment(\.presentationMode) var presentation
  
  @FocusState private var focusedField: NewTargetFormField?
  
  @State private var name: String = ""
  @State private var currentAmount: Int = 0
  @State private var totalAmount: Int = 0
  
  @State var targets: LoadableSubject<LazyList<Target>>
  
  init(_ targets: LoadableSubject<LazyList<Target>>) {
    self._targets = .init(wrappedValue: targets)
  }
  
  var body: some View {
    VStack {
      
      CustomStackView {
        Label {
          Text("На что копим:")
        } icon: {
          Image(systemName: "star")
        }
        
      } contentView: {
        TextField("", text: $name)
          .placeholder(when: name.isEmpty, placeholder: {
            Text("Название цели")
              .foregroundColor(.white)
          })
          .focused($focusedField, equals: .name)
      }
      
      CustomStackView {
        Label {
          Text("Хочу накопить:")
        } icon: {
          Image(systemName: "star")
        }
        
      } contentView: {
        TextField("", value: $totalAmount, formatter: NumberFormatter())
          .focused($focusedField, equals: .totalAmount)
          .keyboardType(.numberPad)
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
          .keyboardType(.numberPad)
      }
      
      Spacer()
      
      Button {
        container.interactors.targetsInteractor.createTarget(name, currentAmount, totalAmount) { result in
          container.interactors.targetsInteractor.loadTargets($targets.wrappedValue)
          self.presentation.wrappedValue.dismiss()
        }
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
