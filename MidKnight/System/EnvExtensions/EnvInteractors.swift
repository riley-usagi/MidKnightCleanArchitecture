extension AppEnvironment {
  
  static func configuredInteractors(
    _ appState: Store<AppState>,
    _ dbServices: Container.DBServices
  ) -> Container.Interactors {
    
    let targetsInteractor = RealTargetsInteractor(
      appState, dbServices.targetsDBService
    )
    
    let todayInteractor = RealTodayInteractor(appState)
    
    let settingsInteractor = RealSettingsInteractor(appState)
    
    return .init(targetsInteractor, todayInteractor, settingsInteractor)
  }
}
