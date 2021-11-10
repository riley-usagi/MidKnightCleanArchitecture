extension Container {
  
  struct Interactors {
    
    let targetsInteractor: TargetsInteractor
    
    let todayInteractor: TodayInteractor
    
    let settingsInteractor: SettingsInteractor
    
    static var stub: Self {
      .init(
        StubTargetsInteractor(),
        StubTodayInteractor(),
        StubSettingsInteractor()
      )
    }
    
    init(
      _ targetsInteractor: TargetsInteractor,
      _ todayInteractor: TodayInteractor,
      _ settingsInteractor: SettingsInteractor
    ) {
      self.targetsInteractor  = targetsInteractor
      self.todayInteractor    = todayInteractor
      self.settingsInteractor = settingsInteractor
    }
  }
}
