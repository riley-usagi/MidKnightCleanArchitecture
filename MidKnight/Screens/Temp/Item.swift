import SwiftUI

struct Item: Identifiable {
  var id = UUID().uuidString
  var title: String
}
