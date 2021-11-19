import SwiftUI

struct LoadingScreen: View {
  
  @Environment(\.container) var container: Container
  
  @State private var firstRunSheetStatus: Bool = false
  
  var body: some View {
    
    ProgressView()
      .onAppear {
        if (UserDefaults.standard.bool(forKey: "HasLaunchedOnce")) {
          changeMainScreen()
        } else {
          firstRunSheetStatus.toggle()
        }
      }
      .sheet(isPresented: $firstRunSheetStatus, onDismiss: nil) {
        
        // Содержимое вступительного экрана
        
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
            Spacer()
            
            
            CustomStackView {
              Label {
                Text("Мошна")
              } icon: {
                Image(systemName: "rublesign.circle")
              }
            } contentView: {
              VStack {
                Text("Приложение помогает распределить деньги на заданный период времени, чтобы убрать лишние траты и помочь накопить на мечту!")
                  .font(.title2)
                  .fontWeight(.semibold)
                  .padding()
                
                HStack(spacing: 0) {
                  
                  Spacer()
                  
                  Text("А то и не на одну... =)")
                    .padding()
                }
              }
              .multilineTextAlignment(.center)
            }
            
            Spacer()
            
            Button {
              
              UserDefaults.standard.set(true, forKey: "HasLaunchedOnce")
              UserDefaults.standard.synchronize()
              
              changeMainScreen()
              
            } label: {
              Text("Понятно")
            }
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
          }
          .padding(.horizontal)
        }
        .interactiveDismissDisabled(true)
      }
  }
  
  func changeMainScreen() {
    container.interactors.loadingInteractor.checkThatNewDayHasCome()
  }
}
