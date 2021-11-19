extension Container {
  
  struct Interactors {
    
    //    let targetsInteractor: TargetsInteractor
    
    let todayInteractor: TodayInteractor
    
    let settingsInteractor: SettingsInteractor
    //
    //    let newDayInteractor: NewDayInteractor
    
    static var stub: Self {
      .init(
        //        StubTargetsInteractor(),
        StubTodayInteractor(),
        StubSettingsInteractor()
        //        StubNewDayInteractor()
      )
    }
    
    init(
      //      _ targetsInteractor: TargetsInteractor,
      _ todayInteractor: TodayInteractor,
      _ settingsInteractor: SettingsInteractor
      //      _ newDayInteractor: NewDayInteractor
    ) {
      //      self.targetsInteractor  = targetsInteractor
      self.todayInteractor    = todayInteractor
      self.settingsInteractor = settingsInteractor
      //      self.newDayInteractor   = newDayInteractor
    }
  }
}
