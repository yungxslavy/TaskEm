import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack {
            //WeekView()
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
