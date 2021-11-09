extension AppEnvironment {
  
  static func configuredInteractors(
    _ appState: Store<AppState>,
    _ dbServices: Container.DBServices
  ) -> Container.Interactors {
    
    let targetsInteractor = RealTargetsInteractor(
      appState, dbServices.targetsDBService
    )
    
    return .init(targetsInteractor)
  }
}
