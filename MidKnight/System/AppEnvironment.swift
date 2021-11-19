struct AppEnvironment {
  let container: Container
}

extension AppEnvironment {
  
  static func bootstrap() -> AppEnvironment {
    
    let appState    = Store<AppState>(AppState())
    
    let dbServices  = configuredDBServices()

    let interactors = configuredInteractors(appState, dbServices)
        
    let container   = Container(appState, interactors)
    
    return AppEnvironment(container: container)
  }
}
