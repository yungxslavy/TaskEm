import SwiftUI



struct ToolbarView: View {
    @Binding var selectedDate: Date
    @Binding var baseDate: Date
    @State private var showDatePicker = false
    
    var body: some View {
        HStack(spacing: 15) {
            // Calendar Button
            Button(action: {
                showDatePicker.toggle()
            }) {
                Image(systemName: "calendar")
                    .foregroundStyle(Color.primary)
                    .imageScale(.large)
            }
            .popover(isPresented: $showDatePicker) {
                VStack {
                    DatePicker("Select Date", selection: $selectedDate, displayedComponents: .date)
                        .datePickerStyle(GraphicalDatePickerStyle())
                        .labelsHidden()
                        .tint(Color.red)
                        .padding()
                        .onChange(of: selectedDate){
                            baseDate = selectedDate
                    }
                    Button(action: {
                        showDatePicker = false
                    }){
                        Text("Done")
                            .foregroundStyle(Color.white)
                            .font(.title)
                    }
                    .padding(10)
                    .background(Color.red)
                    .cornerRadius(10)
                }
                
            }
            
            // Settings view
            NavigationLink(destination: SettingsPageView()) {
                    Image(systemName: "gear")
                        .foregroundStyle(Color.primary)
                        .imageScale(.large)
            }
            
            Button(action: {
                // Action for line.3.horizontal.decrease button
            }) {
                Image(systemName: "line.3.horizontal.decrease")
                    .foregroundStyle(Color.primary)
                    .imageScale(.large)
            }
            
            Button(action: {
                // Action for plus button
            }) {
                Image(systemName: "plus")
                    .foregroundStyle(Color.primary)
                    .imageScale(.large)
            }
        }
    }
}


struct ToolBarInit: View {
    @State var selectedDate = Date()
    @State var baseDate = Date()
    var body: some View {
        ToolbarView(selectedDate: $selectedDate, baseDate: $baseDate)
    }
}

#Preview {
    ToolBarInit()
}
