extension Container {
  
  struct Interactors {
    
    let targetsInteractor: TargetsInteractor
    
    static var stub: Self {
      .init(
        StubTargetsInteractor()
      )
    }
    
    init(
      _ targetsInteractor: TargetsInteractor
    ) {
      self.targetsInteractor = targetsInteractor
    }
  }
}
