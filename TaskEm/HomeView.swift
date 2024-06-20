import SwiftUI

struct HomeView: View {
    @State var selectedDate: Date
    @State var baseDate: Date
    
    var body: some View {
        NavigationView {
            VStack {
                HStack{
                    Text("\(formattedDate(date: selectedDate))")
                        .font(.title)
                        .fontWeight(.bold)
                        .onTapGesture { selectedDate = Date(); baseDate = Date()}
                    Spacer()
                    Image(systemName: "star.fill")
                }
                .padding(5)
                WeeklySlideView(selectedDate: $selectedDate, baseDate: $baseDate)
                    .frame(height: 100)
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
