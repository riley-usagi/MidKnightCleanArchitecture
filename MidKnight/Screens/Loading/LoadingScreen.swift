import SwiftyUserDefaults
import SwiftUI

struct LoadingScreen: View {
  
  @Environment(\.container) var container: Container
  
  var body: some View {
    
    ProgressView()
    
      .onAppear {
        
        // clearAllUserDefaultsData()
        
        // Здесь будет происходить настройка первоначальных флагов
        if !(UserDefaults.standard.bool(forKey: "HasLaunchedOnce")) {
          
          
          // MARK: - День зарплаты
          
          // Дата через 40 дней
          let fouthDaysForward = Calendar.current.date(byAdding: .day, value: 40, to: Date())!
          
          // Задаём дату дефолтной ближайшей зарплаты (40 дней от текущей даты)
          UserDefaults.standard.set(fouthDaysForward, forKey: "PayDay")
          
          
          // MARK: - Денег до зарплаты
          UserDefaults.standard.set(21_000, forKey: "TotalCash")
          
          
          // MARK: - Денег на сегодня
          UserDefaults.standard.set(525, forKey: "TodayCash")
          
          
          // MARK: - Флаг первого посещения
          
          // Устанавливаем флаг о том, что первый запуск приложения произошёл
          UserDefaults.standard.set(true, forKey: "HasLaunchedOnce")
        }
        
        container.appState.value.currentPage = .settings
      }
  }
  
  
  /// Зачиска UserDefaults для разработки
  private func clearAllUserDefaultsData() {
    let domain = Bundle.main.bundleIdentifier!
    UserDefaults.standard.removePersistentDomain(forName: domain)
    UserDefaults.standard.synchronize()
    // print(Array(UserDefaults.standard.dictionaryRepresentation().keys).count)
  }
}
