import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack {
//            ToolbarItem
            WeeklySlideView(selectedDate: Date())
                .frame(height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
            Spacer()
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    HomeView()
}
