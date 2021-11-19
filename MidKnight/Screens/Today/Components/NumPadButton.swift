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
  case clear      = "C"
  case enter      = "OK"
  case emptyZero  = ""
  case emptyEnter = " "
  
  var buttonColor: Color {
    switch self {
    case .clear:
      return .gray
    case .enter, .emptyEnter:
      return .orange
    case .one, .two, .three, .four, .five, .six, .seven, .eight, .nine, .zero, .emptyZero:
      return Color(.white)
    }
  }
}
