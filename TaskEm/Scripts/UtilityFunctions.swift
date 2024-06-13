import Foundation


// Function to get the start and end dates of the week for a specified date
func getDatesInWeek(for date: Date) -> [Date]? {
    // Get the current calendar
    let calendar = Calendar.current
    
    // Get the start of the week for the specified date
    guard let weekInterval = calendar.dateInterval(of: .weekOfYear, for: date) else {
        return nil
    }
    
    // Create an array to store the dates of the week
    var dates = [Date]()
    var currentDate = weekInterval.start
    
    // Loop through the days of the week and add them to the array
    while currentDate < weekInterval.end {
        dates.append(currentDate)
        guard let nextDay = calendar.date(byAdding: .day, value: 1, to: currentDate) else {
            break
        }
        currentDate = nextDay
    }
    
    return dates
}

// Function takes in a date and returns the name of the weekday
func getWeekdayName(for date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "E"
    
    return formatter.string(from: date)
}

// Returns if the dates are the same day or not
func isSameDay(a: Date, b: Date) -> Bool {
    let calendar = Calendar.current
    return calendar.isDate(a, inSameDayAs: b)
}
