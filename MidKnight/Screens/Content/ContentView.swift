import Combine
import SwiftUI

struct ContentView: View {
  
  let exampleProduct: Product = Product(name: "Example Product")
  
  var body: some View {
    Group {
      
      NavigationLink(exampleProduct.name, value: exampleProduct)
      
      NavigationLink {
        Text("Example")
      } label: {
        Text("Simple Link")
      }
    }
    
    .navigationDestination(for: Product.self) { product in
      Text(product.name)
    }
  }
}

struct Product: Hashable {
  var name: String
}
