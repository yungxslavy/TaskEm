import SwiftUI

struct HomeView: View {
    @State var selectedDate: Date
    @State var baseDate: Date
    
    var body: some View {
        NavigationStack{
            VStack {
                // HUD Bar
                HStack{
                    Text("\(formattedDate(date: selectedDate))")
                        .font(.title)
                        .fontWeight(.bold)
                        .onTapGesture { selectedDate = Date(); baseDate = Date()}
                    Spacer()
                    ToolbarView(selectedDate: $selectedDate, baseDate: $baseDate)
                }
                
                // Weekly View Slider
                WeeklySlideView(selectedDate: $selectedDate, baseDate: $baseDate)
                    .frame(height: 80)
                
                // Task View
                ScrollView {
                    TaskView()
                }
                .scrollIndicators(.hidden)
                Spacer()
            }
            .padding()
        }
    }
}

#Preview {
    HomeView(selectedDate: Date(), baseDate: Date())
}
