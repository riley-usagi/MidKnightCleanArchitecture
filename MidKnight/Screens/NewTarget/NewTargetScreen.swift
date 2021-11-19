import SwiftUI

struct NewTargetScreen: View {
  
  @Environment(\.container) var container: Container
  
  @Environment(\.presentationMode) var presentation
  
  @State var targets: LoadableSubject<LazyList<Target>>
  
  @State private var name: String       = ""
  @State private var currentAmount: Int?
  @State private var totalAmount: Int?
  
  init(_ targets: LoadableSubject<LazyList<Target>>) {
    self._targets = .init(wrappedValue: targets)
  }
  
  var body: some View {
    
    ZStack {
      
      GeometryReader { reader in
        
        Image("background")
          .resizable()
          .aspectRatio(1, contentMode: .fill)
          .frame(width: reader.size.width, height: reader.size.height)
        
      }
      .ignoresSafeArea()
      .overlay(.ultraThinMaterial)
      
      VStack(spacing: 0) {
        
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
        }
        
        CustomStackView {
          Label {
            Text("Начальная сумма:")
          } icon: {
            Image(systemName: "star")
          }
          
        } contentView: {
          TextField("Уже имею", value: $currentAmount, formatter: NumberFormatter(), prompt: nil)
            .placeholder(when: currentAmount == nil, placeholder: {
              Text("Начальная сумма")
                .foregroundColor(.white)
            })
            .keyboardType(.numberPad)
        }
        
        CustomStackView {
          Label {
            Text("Хочу накопить:")
          } icon: {
            Image(systemName: "star")
          }
          
        } contentView: {
          TextField("", value: $totalAmount, formatter: NumberFormatter())
            .placeholder(when: totalAmount == nil, placeholder: {
              Text("Итоговая сумма")
                .foregroundColor(.white)
            })
            .keyboardType(.numberPad)
        }
        
        Button {
          container.interactors.targetsInteractor.createTarget(name, currentAmount, totalAmount) { result in
            container.interactors.targetsInteractor.loadTargets($targets.wrappedValue)
            self.presentation.wrappedValue.dismiss()
          }
        } label: {
          Text("Создать")
        }
        .disabled((totalAmount == nil) || (currentAmount == nil))
        .disabled(name.isEmpty)
        .disabled(currentAmount ?? 0 >= totalAmount ?? 0)
        .buttonStyle(PlainButtonStyle())
        .font(.title3.bold())
        .padding(.vertical, 22)
        .frame(maxWidth: .infinity)
        .background(
          .linearGradient(
            .init(colors: [
              Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)),
              Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1))
            ]),
            startPoint: .leading, endPoint: .trailing
          ), in: RoundedRectangle(cornerRadius: 20)
        )
        .foregroundColor(.white)
        
        Spacer()
      }
      .padding(.horizontal)
    }
  }
}
