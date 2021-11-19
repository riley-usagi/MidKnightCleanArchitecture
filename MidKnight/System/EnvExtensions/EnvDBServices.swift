extension AppEnvironment {
  
  static func configuredDBServices() -> Container.DBServices {
    
    let persistentStore = CoreDataStack()
    
//    let targetsDBService = RealTargetsDBService(persistentStore)
    
    return .init(
//      targetsDBService
    )
  }
}
