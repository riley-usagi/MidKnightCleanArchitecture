import SwiftUI

enum NumPadButton: String {
  case one        = "1"
  case two        = "2"
  case three      = "3"
  case four       = "4"
  case five       = "5"
  case six        = "6"
  case seven      = "7"
  case eight      = "8"
  case nine       = "9"
  case zero       = "0"
  case clear      = "⌫"
  case enter      = "↵"
  case emptyZeroLeft  = ""
  case emptyZeroRight = " "
  case emptyEnter     = "  "
  
  var buttonColor: Color {
    switch self {
    case .clear:
      return Color(#colorLiteral(red: 0.731742382, green: 0.7273942828, blue: 0.7350859046, alpha: 1))
    case .enter, .emptyEnter:
      return .orange
    case .one, .two, .three, .four, .five, .six, .seven, .eight, .nine, .zero, .emptyZeroLeft, .emptyZeroRight:
      return Color(.white)
    }
  }
  
  var labelColor: Color {
    switch self {
    case .clear:
      return Color(#colorLiteral(red: 0.4142154157, green: 0.4117577672, blue: 0.416107595, alpha: 1))
    case .enter, .emptyEnter:
      return Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.6500000000))
    case .one, .two, .three, .four, .five, .six, .seven, .eight, .nine, .zero, .emptyZeroLeft, .emptyZeroRight:
      return .black
    }
  }
  
  var font: Font {
    switch self {
    case .clear:
      return Font.system(size: 32, weight: .light)
    case .enter, .emptyEnter:
      return Font.system(size: 38, weight: .light)
    case .one, .two, .three, .four, .five, .six, .seven, .eight, .nine, .zero, .emptyZeroLeft, .emptyZeroRight:
      return Font.system(size: 28, weight: .light)
    }
  }
  
}
