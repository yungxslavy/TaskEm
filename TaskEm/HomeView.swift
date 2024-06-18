import SwiftUI

struct HomeView: View {
    @State var selectedDate: Date
    
    var body: some View {
        NavigationView {
            VStack {
                HStack{
                    Text("\(formattedDate(date: selectedDate))")
                        .font(.title)
                        .fontWeight(.bold)
                    Spacer()
                    Image(systemName: "star.fill")
                }
                .padding(5)
                WeeklySlideView(selectedDate: $selectedDate)
                    .frame(height: 100)
                Spacer()

            }
            .padding()
        }
    }
}

#Preview {
    HomeView(selectedDate: Date())
}
