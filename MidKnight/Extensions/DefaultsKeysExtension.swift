import Foundation
import SwiftyUserDefaults

extension DefaultsKeys {
  
  /// День зарплаты
  var payDay: DefaultsKey<Date> {
    .init("PayDay", defaultValue: Calendar.current.date(byAdding: .day, value: 40, to: Date())!)
  }
  
  /// Деньги до зарплаты
  var totalCash: DefaultsKey<Int> { .init("TotalCash", defaultValue: 21_000) }
  
  /// Сумма на день
  var todayCash: DefaultsKey<Int> { .init("TodayCash", defaultValue: 525) }
}
