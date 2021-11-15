import SwiftUI

struct CustomStackView<Title: View, Content: View>: View {
  
  var titleView: Title
  var contentView: Content
  
  init(@ViewBuilder titleView: @escaping () -> Title, @ViewBuilder contentView: @escaping () -> Content) {
    self.titleView    = titleView()
    self.contentView  = contentView()
  }
  
  var body: some View {
    
    VStack(spacing: 0) {
      
      titleView
        .font(.callout)
        .lineLimit(1)
        .frame(height: 38)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.leading)
        .background(
          //          .ultraThinMaterial,
          Color.white.opacity(0.1),
          in: CustomCorner(corners: [.topLeft, .topRight], radius: 12)
        )
      
      VStack {
        
        Divider()
        
        contentView
          .padding()
      }
      .background(
        //        .ultraThinMaterial,
        Color.white.opacity(0.1),
        in: CustomCorner(
          corners: [.bottomLeft, .bottomRight], radius: 12
        )
      )
    }
    .background(
      RoundedRectangle(cornerRadius: 12)
        .fill(.white)
        .opacity(0.1)
        .background(
          Color.white
            .opacity(0.08)
            .blur(radius: 10)
        )
        .background(
          RoundedRectangle(cornerRadius: 12)
            .stroke(
              .linearGradient(
                colors: [
                  Color.purple,
                  Color.purple.opacity(0.5),
                  .clear,
                  .clear,
                  Color(#colorLiteral(red: 0.4904261827, green: 0.8145822883, blue: 0.8926784396, alpha: 1))
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
              ), lineWidth: 2.5
            )
            .padding(2)
        )
        .shadow(color: .black.opacity(0.1), radius: 5, x: -5, y: -5)
        .shadow(color: .black.opacity(0.1), radius: 5, x: 5, y: 5)
    )
    .colorScheme(.light)
    
  }
}
