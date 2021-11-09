extension Container {
  
  struct DBServices {
    
    let targetsDBService: TargetsDBService
    
    init(_ targetsDBService: TargetsDBService) {
      self.targetsDBService = targetsDBService
    }
  }
}
