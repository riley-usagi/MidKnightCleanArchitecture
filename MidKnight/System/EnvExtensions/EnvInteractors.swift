extension AppEnvironment {
  
  static func configuredInteractors(
    _ appState: Store<AppState>,
    _ dbServices: Container.DBServices
  ) -> Container.Interactors {
    
    let todayInteractor     = RealTodayInteractor(appState)
    
    let settingsInteractor  = RealSettingsInteractor(appState)
    
    let loadingInteractor   = RealLoadingInteractor(appState)
    
    let newDayInteractor    = RealNewDayInteractor(
      appState, dbServices.targetsDBService
    )
    
    let targetsInteractor   = RealTargetsInteractor(
      appState, dbServices.targetsDBService
    )
    
    return .init(
      targetsInteractor,
      todayInteractor,
      settingsInteractor,
      newDayInteractor,
      loadingInteractor
    )
  }
}
