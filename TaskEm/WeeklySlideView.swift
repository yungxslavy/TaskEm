import SwiftUI

// View for the specific day of the week
struct WeekDayButton: View {
    @Binding var selectedDate: Date
    
    var date: Date
    var isSelected: Bool
    var color: Color {
        isSelected ? Color.red : Color.primary
    }
    
    var body: some View {
        Button(action: {
            selectedDate = date
        }) {
            VStack {
                Text(getWeekdayName(for: date))
                    .padding(.bottom, 4)
                    .font(.caption)
                Text("\(Calendar.current.component(.day, from: date))")
                    .bold()
            }
        }
        .padding(7)
        .foregroundStyle(color)
    }
}

// View for the week
struct WeeklySlideView: View {
    @State var selectedDate: Date
    
    var weeklyDates: [Date] { getDatesInWeek(for: selectedDate) ?? [] }

    var body: some View {
        HStack(alignment: .center) {
            ForEach(weeklyDates.indices, id: \.self) { index in
                let date = weeklyDates[index]
                let isSelected = isSameDay(a: date, b: selectedDate)
                WeekDayButton(selectedDate: $selectedDate, date: date, isSelected: isSelected)
                if index < weeklyDates.count - 1 {
                    Spacer()
                }
            }
        }
        .padding()
    }
}



// Function to get a specified date
func getSpecifiedDate(year: Int, month: Int, day: Int) -> Date? {
    var dateComponents = DateComponents()
    dateComponents.year = year
    dateComponents.month = month
    dateComponents.day = day
    
    return Calendar.current.date(from: dateComponents)
}

struct WeeklySlide_Previews: PreviewProvider {
    static var previews: some View {
        WeeklySlideView(selectedDate: getSpecifiedDate(year: 2024, month: 6, day: 14)!)
    }
}
