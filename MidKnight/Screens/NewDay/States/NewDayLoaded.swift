import SwiftUI

extension NewDayScreen {
  
  func loadedView(_ targets: LazyList<Target>) -> some View {
    
    VStack(spacing: 0) {
      
      // MARK: - Title
      
      Text("На что потратим?")
        .font(.largeTitle.bold())
        .foregroundColor(.white)
        .padding()
      
      
      // MARK: - Choose
      
      CustomStackView {
        Text("Поделить на все дни до зарплаты")
      } contentView: {
        Text("Content")
      }
      .padding(.bottom)
      .onTapGesture {
        container.interactors.newDayInteractor.spentSomeMoney(.divide)
      }
      
      CustomStackView {
        Text("Потратить всё сегодня")
      } contentView: {
        Text("Content")
      }
      .padding(.bottom)
      .onTapGesture {
        container.interactors.newDayInteractor.spentSomeMoney(.today)
      }
      
      Divider()
        .padding()
      
      
      // MARK: - Targets title
      
      Text("Цели не заданы")
        .font(.largeTitle.bold())
        .foregroundColor(.white)
        .padding(.bottom)
      
      
      // MARK: - Targets list
      
      ScrollView(.vertical, showsIndicators: false) {
        
        ForEach(targets) { target in
          
          CustomStackView {
            Text(target.name.capitalized)
          } contentView: {
            Text("Content")
          }
          .onTapGesture {
            container.interactors.newDayInteractor.spentSomeMoney(.target(id: target.id))
          }
        }
      }
      
      
      
      // MARK: - Spacer
      
      Spacer()
    }
    .padding()
    .padding(.top)
    
  }
}
