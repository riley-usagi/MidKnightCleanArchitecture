import SwiftUI

struct BackgroundView: View {
  var body: some View {
    
    ZStack {
      
      LinearGradient(
        colors: [
          Color(#colorLiteral(red: 0.07427979261, green: 0.1421449482, blue: 0.3626214266, alpha: 1)),
          Color(#colorLiteral(red: 0.06866233051, green: 0.1796298921, blue: 0.3614529967, alpha: 1))
        ],
        startPoint: .top,
        endPoint: .bottom
      ).ignoresSafeArea()
      
      GeometryReader { reader in
        
        let size = reader.size
        
        Color.black
          .opacity(0.7)
          .blur(radius: 200)
          .ignoresSafeArea()
        
        Circle()
          .fill(
            Color(#colorLiteral(red: 0.44226408, green: 0.2756455541, blue: 0.6897320151, alpha: 1))
          )
          .padding(50)
          .blur(radius: 120)
          .offset(x: -size.width / 1.8, y: -size.height / 5)
       
        Circle()
          .fill(
            Color(#colorLiteral(red: 0.1805429161, green: 0.3903315067, blue: 0.5716809034, alpha: 1))
          )
          .padding(50)
          .blur(radius: 150)
          .offset(x: size.width / 1.8, y: -size.height / 2)
        
        Circle()
          .fill(
            Color(#colorLiteral(red: 0.1805429161, green: 0.3903315067, blue: 0.5716809034, alpha: 1))
          )
          .padding(100)
          .blur(radius: 90)
          .offset(x: size.width / 1.8, y: size.height / 2)
        
        Circle()
          .fill(
            Color(#colorLiteral(red: 0.4730705023, green: 0.4095332921, blue: 0.6843951344, alpha: 1))
          )
          .padding(100)
          .blur(radius: 110)
          .offset(x: size.width / 1.8, y: size.height / 2)
        
        Circle()
          .fill(
            Color(#colorLiteral(red: 0.4730705023, green: 0.4095332921, blue: 0.6843951344, alpha: 1))
          )
          .padding(100)
          .blur(radius: 110)
          .offset(x: -size.width / 1.8, y: size.height / 2)
      }
      
    }
  }
}
