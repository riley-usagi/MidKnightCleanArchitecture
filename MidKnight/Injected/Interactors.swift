extension Container {
  
  struct Interactors {
    
    let targetsInteractor: TargetsInteractor
    
    let todayInteractor: TodayInteractor
    
    static var stub: Self {
      .init(
        StubTargetsInteractor(),
        StubTodayInteractor()
      )
    }
    
    init(
      _ targetsInteractor: TargetsInteractor,
      _ todayInteractor: TodayInteractor
    ) {
      self.targetsInteractor  = targetsInteractor
      self.todayInteractor    = todayInteractor
    }
  }
}
