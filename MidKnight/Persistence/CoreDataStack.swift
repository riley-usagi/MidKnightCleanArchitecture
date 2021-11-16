import Combine
import CoreData

protocol PersistentStore {
  typealias DBOperation<Result> = (NSManagedObjectContext) throws -> Result
  
  /// Процесс получения данных из CoreData и их подсчёт
  /// - Parameter fetchRequest: Объект запроса к базе данных
  func count<T>(_ fetchRequest: NSFetchRequest<T>) -> AnyPublisher<Int, Error>
  
  /// Процесс получения данных из CoreData
  /// - Parameter fetchRequest: Объект запроса к базе данных
  func fetch<T, V>(
    _ fetchRequest: NSFetchRequest<T>,
    map: @escaping (T) throws -> V?
  ) -> AnyPublisher<LazyList<V>, Error>
  
  /// Процесс обновления данных в CoreData
  /// - Parameter operation: Контекст с операцией обновления
  func update<Result>(_ operation: @escaping DBOperation<Result>) -> AnyPublisher<Result, Error>
  
  func delete<T>(_ fetchRequest: NSFetchRequest<T>) -> AnyPublisher<Void, Error>
}

struct CoreDataStack: PersistentStore {
  
  private let container: NSPersistentContainer
  private let bgQueue = DispatchQueue(label: "coredata")
  private let isStoreLoaded = CurrentValueSubject<Bool, Error>(false)
  
  
  // MARK: - Init
  
  init(
    directory: FileManager.SearchPathDirectory    = .documentDirectory,
    domainMask: FileManager.SearchPathDomainMask  = .userDomainMask
  ) {
    container = NSPersistentContainer(name: "MidKnightDataBase")
    
    if let url = dbFileURL(directory, domainMask) {
      let store = NSPersistentStoreDescription(url: url)
      container.persistentStoreDescriptions = [store]
    }
    
    bgQueue.async { [weak isStoreLoaded, weak container] in
      
      container?.loadPersistentStores(completionHandler: { storeDescription, error in
        
        DispatchQueue.main.async {
          
          if let error = error {
            isStoreLoaded?.send(completion: .failure(error))
          } else {
            container?.viewContext.configureAsReadOnlyContext()
            isStoreLoaded?.value = true
          }
        }
      })
    }
    
//    // MARK: - Clear
//    guard let url = container.persistentStoreDescriptions.first?.url else { return }
//    
//    let persistentStoreCoordinator = container.persistentStoreCoordinator
//    
//    do {
//      try persistentStoreCoordinator.destroyPersistentStore(at:url, ofType: NSSQLiteStoreType, options: nil)
//      try persistentStoreCoordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: nil)
//    } catch {
//      print("Attempted to clear persistent store: " + error.localizedDescription)
//    }
    
  }
  
  
  // MARK: - Methods
  
  func count<T>(_ fetchRequest: NSFetchRequest<T>) -> AnyPublisher<Int, Error> {
    return onStoreIsReady
      .flatMap { [weak container] in
        Future<Int, Error> { promise in
          do {
            let count = try container?.viewContext.count(for: fetchRequest) ?? 0
            promise(.success(count))
          } catch {
            promise(.failure(error))
          }
        }
      }
      .eraseToAnyPublisher()
  }
  
  func delete<T>(_ fetchRequest: NSFetchRequest<T>) -> AnyPublisher<Void, Error> {
    
    return onStoreIsReady
      .flatMap { [weak container] in
        Future<Void, Error> { promise in
          do {
            let objects = try container?.viewContext.fetch(fetchRequest)
            
            if let mo = objects![0] as? NSManagedObject {
              // Turning object into a fault
              container?.viewContext.refresh(mo, mergeChanges: false)
              
              container?.viewContext.delete(mo)
              
              try container?.viewContext.save()
              
            }
            
            promise(.success(()))
          } catch {
            promise(.failure(error))
          }
        }
      }
      .eraseToAnyPublisher()
  }
  
  func fetch<T, V>(_ fetchRequest: NSFetchRequest<T>,
                   map: @escaping (T) throws -> V?) -> AnyPublisher<LazyList<V>, Error> {
    
    
    assert(Thread.isMainThread)
    
    let fetch = Future<LazyList<V>, Error> { [weak container] promise in
      guard let context = container?.viewContext else { return }
      context.performAndWait {
        do {
          let managedObjects = try context.fetch(fetchRequest)
          let results = LazyList<V>(count: managedObjects.count,
                                    useCache: true) { [weak context] in
            let object = managedObjects[$0]
            let mapped = try map(object)
            if let mo = object as? NSManagedObject {
              // Turning object into a fault
              context?.refresh(mo, mergeChanges: false)
            }
            return mapped
          }
          promise(.success(results))
        } catch {
          promise(.failure(error))
        }
      }
    }
    return onStoreIsReady
      .flatMap { fetch }
      .eraseToAnyPublisher()
  }
  
  func update<Result>(_ operation: @escaping DBOperation<Result>) -> AnyPublisher<Result, Error> {
    let update = Future<Result, Error> { [weak bgQueue, weak container] promise in
      bgQueue?.async {
        
        guard let context = container?.newBackgroundContext() else { return }
        
        context.configureAsUpdateContext()
        
        context.performAndWait {
          do {
            let result = try operation(context)
            if context.hasChanges {
              try context.save()
            }
            context.reset()
            promise(.success(result))
          } catch {
            context.reset()
            promise(.failure(error))
          }
        }
      }
    }
    
    return onStoreIsReady
      .flatMap { update }
      .receive(on: DispatchQueue.main)
      .eraseToAnyPublisher()
  }
  
  private var onStoreIsReady: AnyPublisher<Void, Error> {
    return isStoreLoaded
      .filter { $0 }
      .map { _ in }
      .eraseToAnyPublisher()
  }
}


extension CoreDataStack {
  private func dbFileURL(
    _ directory: FileManager.SearchPathDirectory,
    _ domainMask: FileManager.SearchPathDomainMask
  ) -> URL? {
    
    return FileManager.default.urls(
      for: directory, in: domainMask
    )
      .first?
      .appendingPathComponent("db.sql")
  }
}
