import SwiftUI

struct NewDayScreen: View {
  
  @Environment(\.container) var container: Container
  
  @State private var targets: Loadable<LazyList<Target>>
  
  @Environment(\.presentationMode) var presentation
  
  init(_ targets: Loadable<LazyList<Target>> = .notRequested) {
    self._targets = .init(initialValue: targets)
  }
  
  var body: some View {
    content
  }
}


// MARK: - Content

extension NewDayScreen {
  var content: some View {
    switch targets {
      
    case .notRequested:
      return AnyView(notRequestedView)
    case .isLoading:
      return AnyView(ProgressView())
    case let .loaded(targets):
      return AnyView(loadedView(targets))
    case .failed:
      return AnyView(Text("Failed"))
    }
  }
}


// MARK: - Not requested

extension NewDayScreen {
  private var notRequestedView: some View {
    Text("")
      .onAppear {
        container.interactors.targetsInteractor.loadTargets($targets)
      }
  }
}


// MARK: - Loaded

extension NewDayScreen {
  
  func loadedView(_ targets: LazyList<Target>) -> some View {
    VStack(spacing: 0) {
      
      // MARK: - Title
      
      Text("На что потратим?")
        .font(.largeTitle.bold())
      //        .foregroundColor(.white)
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
        
        presentation.wrappedValue.dismiss()
      }
      
      CustomStackView {
        Text("Потратить всё сегодня")
      } contentView: {
        Text("Content")
      }
      .padding(.bottom)
      .onTapGesture {
        container.interactors.newDayInteractor.spentSomeMoney(.today)
        
        presentation.wrappedValue.dismiss()
      }
      
      Divider()
        .padding()
      
      
      // MARK: - Targets title
      
      Text("Цели не заданы")
        .font(.largeTitle.bold())
        .foregroundColor(.white)
        .padding(.bottom)
      
      
      // MARK: - Targets list
      
      ScrollView(.vertical, showsIndicators: true) {
        
        ForEach(targets) { target in
          
          CustomStackView {
            Text(target.name.capitalized)
          } contentView: {
            Text("Content")
          }
          .onTapGesture {
            container.interactors.newDayInteractor.spentSomeMoney(.target(id: target.id))
            
            presentation.wrappedValue.dismiss()
          }
        }
      }
      
      
      // MARK: - Spacer
      
      Spacer()
    }
    .padding(.horizontal)
    
  }
}
