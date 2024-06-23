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
    // Bindings and States
    @Binding var selectedDate: Date
    @Binding var baseDate: Date
    @State private var selectedTab = 5
    @State private var isTransitioning = false

    // Week related values
    var totalNumofWeeks = 10 // Ensure this is even
    var weeksRange: Range<Int> { 0..<totalNumofWeeks + 1 }
    @State private var isResetting = false
    
    // Function returns array of dates to fill out the weekly view dynamically
    func getWeekDates(for index: Int) -> [Date] {
        let weeksFromCurrent = index - (totalNumofWeeks / 2)
        return getDatesInWeek(for: getDateByWeekChange(weeks: weeksFromCurrent, date: baseDate)!) ?? []
    }
    
    // Main
    var body: some View {
        TabView(selection: $selectedTab) {
            ForEach(weeksRange, id: \.self) { index in
                HStack(alignment: .center) {
                    ForEach(getWeekDates(for: index).indices, id: \.self) { dayIndex in
                        let date = getWeekDates(for: index)[dayIndex]
                        let isSelected = isSameDay(a: date, b: selectedDate)
                        WeekDayButton(selectedDate: $selectedDate, date: date, isSelected: isSelected)
                        if dayIndex < getWeekDates(for: index).count - 1 {
                            Spacer()
                        }
                    }
                }
                .padding(10)
                .tag(index)
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never)) // Removes the page dots
        .onChange(of: baseDate){
            // In case the tab is already on 5 we still send input
            if selectedTab == 5 {
                UIImpactFeedbackGenerator(style: .light).impactOccurred()
            }
            selectedTab = totalNumofWeeks / 2
        }
        .onChange(of: selectedTab) {
            // Check if the tab is currently resetting
            if(isResetting){
                isResetting = false
                return
            }
            
            // Add a thread to the queue to activate after .5 secs
            isTransitioning = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                // Our debounce check
                if isTransitioning {
                    // Get the difference in days for the selectedDate
                    let diff = getDifferenceInWeekDay(xDate: baseDate, yDate: selectedDate)
                    
                    // Change the week to the respective tab and add the days to match the correct day
                    selectedDate = getDateByWeekChange(weeks: selectedTab - (totalNumofWeeks / 2), date: baseDate)!
                    selectedDate = getDateByDayChange(days: diff, date: selectedDate)!
                    
                    // Send feedback to user
                    UIImpactFeedbackGenerator(style: .light).impactOccurred()
                    
                    // When reaching the boundary we reset the tabs
                    if selectedTab >= weeksRange.upperBound - 2 || selectedTab <= weeksRange.lowerBound + 1 {
                        // Set the dates to equal each other again
                        baseDate = selectedDate
                        selectedTab = totalNumofWeeks / 2
                        isResetting = true
                    }
                }
                // Set this back to false to allow the logic to run again
                isTransitioning = false
            }
        }
    }
}

struct sampleView: View {
    @State var selectedDate = Date()
    @State var baseDate = Date()
    var body: some View {
        WeeklySlideView(selectedDate: $selectedDate, baseDate: $baseDate)
    }
}

struct WeeklySlide_Previews: PreviewProvider {
    static var previews: some View {
        sampleView()
    }
}
