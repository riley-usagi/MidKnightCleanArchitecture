import Foundation

extension Date {
  
  /// Список дат на ближайшие сорок дней
  /// - Returns: Список дат
  static func arrayOfFourthDays() -> [Self] {
    
    var dates = [Self]()
    var date = Self()
    let endDate = Calendar.current.date(
      byAdding: .day, value: 39, to: date
    )!
    
    dates.append(date)
    
    while date < endDate {
      date = Calendar.current.date(byAdding: .day, value: 1, to: date)!
      dates.append(date)
    }
    
    return dates
  }
  
  /// Возвращает просклонённый "день"
  /// - Parameter dayNumber: Номер дня
  /// - Returns: Просклонённый "день"
  static func dayDeclension(dayNumber: Int) -> String {
    
    if 5...20 ~= dayNumber {
      return "дней"
    }
    
    switch dayNumber % 10 {
      
    case 1:
      return "день"
      
    case 2...4:
      return "дня"
      
    default:
      return "дней"
    }
  }
}
