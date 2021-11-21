import SwiftUI

struct TargetsScreen: View {
  
  @Environment(\.container) var container: Container
  
  @State var targets: Loadable<LazyList<Target>>
  
  @State var newTargetScreenStatus: Bool = false
  
  init(targets: Loadable<LazyList<Target>> = .notRequested) {
    self._targets = .init(initialValue: targets)
  }
  
  var body: some View {
    content
      .sheet(isPresented: $newTargetScreenStatus, onDismiss: nil) {
        NewTargetScreen($targets)
      }
  }
}


// MARK: - Content

extension TargetsScreen {
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

extension TargetsScreen {
  private var notRequestedView: some View {
    Text("")
      .onAppear {
        container.interactors.targetsInteractor.loadTargets($targets)
      }
  }
}


// MARK: - Loaded

extension TargetsScreen {
  func loadedView(_ targets: LazyList<Target>) -> some View {
    ZStack {
      
      
      if targets.count == 0 {
        
        VStack(spacing: 0) {
          HStack(spacing: 0) {
            
            Spacer()
            
            Button {
              container.appState[\.currentPage] = .today
            } label: {
              HStack(spacing: 5) {
                Text("Назад")
                Image(systemName: "arrow.right")
              }
              .font(.title3.bold())
            }
          }
          .foregroundColor(.white)
          
          Spacer()
          
          Text("Целей нет")
            .shadow(color: .black, radius: 50, x: 0, y: 0)
            .font(.largeTitle.bold())
            .foregroundColor(.white)
          
          Spacer()
          
        }
      } else {
        
        VStack(spacing: 0) {
          
          HStack(spacing: 0) {
            
            Spacer()
            
            Button {
              container.appState[\.currentPage] = .today
            } label: {
              HStack(spacing: 5) {
                Text("Назад")
                Image(systemName: "arrow.right")
              }
              .font(.title3.bold())
            }
          }
          .foregroundColor(.white)
          .padding(.bottom)
          
          ScrollView(.vertical, showsIndicators: false) {
            
            ForEach(targets) { target in
              
              CustomStackView {
                Label {
                  Text(target.name)
                } icon: {
                  Image(systemName: "star")
                }
              } contentView: {
                
                HStack(spacing: 0) {
                  Text(String(target.currentAmount))
                    .foregroundColor(Color(#colorLiteral(red: 0.7820102572, green: 0.7773627639, blue: 0.7855834961, alpha: 1)))
                  
                  Text(" из ")
                    .foregroundColor(Color(#colorLiteral(red: 0.8527202606, green: 0.8476518989, blue: 0.8566166759, alpha: 1)))
                  
                  Text(String(target.totalAmount))
                }
                .font(.system(size: 36).bold())
              }
              .contextMenu {
                Button {
                  DispatchQueue.main.async {
                    withAnimation(.spring()) {
                      container.interactors.targetsInteractor.removeTarget(target.id)
                      container.interactors.targetsInteractor.loadTargets($targets)
                    }
                  }
                } label: {
                  Text("Удалить")
                }
                
              }
              
              
            }
          }
          .padding(.bottom, 100)
//          .padding(.horizontal)
          
        }
      }
      
      VStack(spacing: 0) {
        
        Spacer()
        
        Button {
          newTargetScreenStatus.toggle()
        } label: {
          Text("Создать")
        }
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
        
      }
    }
    .ignoresSafeArea()
    .padding()
  }
}
