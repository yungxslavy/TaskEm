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
    @State private var selectedTab = 1
    @State private var isTransitioning = false

    var currentWeekDates: [Date] { getDatesInWeek(for: selectedDate) ?? [] }
    var nextWeekDates: [Date] { getDatesInWeek(for: getDateByWeekChange(weeks: 1, date: selectedDate)!) ?? [] }
    var lastWeekDates: [Date] { getDatesInWeek(for: getDateByWeekChange(weeks: -1, date: selectedDate)!) ?? [] }
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HStack(alignment: .center) {
                ForEach(lastWeekDates.indices, id: \.self) { index in
                    let date = lastWeekDates[index]
                    let isSelected = isSameDay(a: date, b: selectedDate)
                    WeekDayButton(selectedDate: $selectedDate, date: date, isSelected: isSelected)
                    if index < lastWeekDates.count - 1 {
                        Spacer()
                    }
                }
            }
            .padding()
            .tag(0)
            
            HStack(alignment: .center) {
                ForEach(currentWeekDates.indices, id: \.self) { index in
                    let date = currentWeekDates[index]
                    let isSelected = isSameDay(a: date, b: selectedDate)
                    WeekDayButton(selectedDate: $selectedDate, date: date, isSelected: isSelected)
                    if index < currentWeekDates.count - 1 {
                        Spacer()
                    }
                }
            }
            .padding()
            .tag(1)
            
            HStack(alignment: .center) {
                ForEach(nextWeekDates.indices, id: \.self) { index in
                    let date = nextWeekDates[index]
                    let isSelected = isSameDay(a: date, b: selectedDate)
                    WeekDayButton(selectedDate: $selectedDate, date: date, isSelected: isSelected)
                    if index < nextWeekDates.count - 1 {
                        Spacer()
                    }
                }
            }
            .padding()
            .tag(2)
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .onChange(of: selectedTab) {
            isTransitioning = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                if isTransitioning {
                    if selectedTab == 2 {
                        selectedDate = getDateByWeekChange(weeks: 1, date: selectedDate)!
                    } else if selectedTab == 0 {
                        selectedDate = getDateByWeekChange(weeks: -1, date: selectedDate)!
                    }
                    selectedTab = 1
                    isTransitioning = false
                }
            }
        }
//        .background(Color.green)
    }
}

struct WeeklySlide_Previews: PreviewProvider {
    static var previews: some View {
        WeeklySlideView(selectedDate: getSpecifiedDate(year: 2024, month: 6, day: 14)!)
    }
}
