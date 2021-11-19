extension Container {
  
  struct Interactors {
    
    let targetsInteractor: TargetsInteractor
    
    let todayInteractor: TodayInteractor
    
    let settingsInteractor: SettingsInteractor
    
    let newDayInteractor: NewDayInteractor
    
    let loadingInteractor: LoadingInteractor
    
    static var stub: Self {
      .init(
        StubTargetsInteractor(),
        StubTodayInteractor(),
        StubSettingsInteractor(),
        StubNewDayInteractor(),
        StubLoadingInteractor()
      )
    }
    
    init(
      _ targetsInteractor: TargetsInteractor,
      _ todayInteractor: TodayInteractor,
      _ settingsInteractor: SettingsInteractor,
      _ newDayInteractor: NewDayInteractor,
      _ loadingInteractor: LoadingInteractor
    ) {
      self.targetsInteractor  = targetsInteractor
      self.todayInteractor    = todayInteractor
      self.settingsInteractor = settingsInteractor
      self.newDayInteractor   = newDayInteractor
      self.loadingInteractor  = loadingInteractor
    }
  }
}
