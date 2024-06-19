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

// Returns the Date of a specified number of weeks from the passed date
func getDateByWeekChange(weeks: Int, date: Date) -> Date? {
    let calendar = Calendar.current
    if let newDate = calendar.date(byAdding: .weekOfYear, value: weeks, to: date) {
        return newDate
    }
    else {
        return nil
    }
}

func getDateByDayChange(days: Int, date: Date) -> Date? {
    let calendar = Calendar.current
    if let newDate = calendar.date(byAdding: .day, value: days, to: date) {
        return newDate
    }
    else {
        return nil
    }
}

// Returns a date from given year month and day
func getSpecifiedDate(year: Int, month: Int, day: Int) -> Date? {
    var dateComponents = DateComponents()
    dateComponents.year = year
    dateComponents.month = month
    dateComponents.day = day
    
    return Calendar.current.date(from: dateComponents)
}

// Returns the index of the weekday from date where 0 = Sun and 6 = Sat
func getWeekDay(date: Date) -> Int {
    let calendar = Calendar.current
    let components = calendar.component(.weekday, from: date)
    return components - 1
}

// Returns the days ahead/behind yDate is to xDate as Int. 0 = sameday | 1
func getDifferenceInWeekDay(xDate: Date, yDate: Date) -> Int {
    let xDateWeekday = getWeekDay(date: xDate)
    let yDateWeekday = getWeekDay(date: yDate)
    
    return yDateWeekday - xDateWeekday
}

// Returns MMMM and YYYY of the date as string
func formattedDate(date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MMMM, yyyy"
    return dateFormatter.string(from: date)
}

class ReloadViewHelper: ObservableObject {
    func reloadView() {
        objectWillChange.send()
    }
}
