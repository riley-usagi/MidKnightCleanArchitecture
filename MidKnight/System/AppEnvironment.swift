struct AppEnvironment {
  let container: Container
}

extension AppEnvironment {
  
  static func bootstrap() -> AppEnvironment {
    
    let appState    = Store<AppState>(AppState())
    
    let interactors = configuredInteractors(appState)
    
    let container   = Container(appState, interactors)
    
    return AppEnvironment(container: container)
  }
}
