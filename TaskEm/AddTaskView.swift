import SwiftUI

struct AddTaskView: View {
    @State private var title: String = ""
    @State private var showIconPicker = false
    @State private var selectedIconName = "star"
    @State private var iconColor = Color.blue
    @State private var dueDate = Date()
    @State private var isTime = false
    @State private var repeatOption: Int = 0
    @State private var reminderDiffSecs: [Int]? = nil
    @State private var notes: String = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            ScrollView {
                TaskTitleSection(title: $title, showIconPicker: $showIconPicker, selectedIconName: $selectedIconName, iconColor: $iconColor)
                DueDateSection(dueDate: $dueDate, isTime: $isTime, iconColor: iconColor)
                ColorSection(iconColor: $iconColor)
                RepeatSection(repeatOption: $repeatOption, iconColor: iconColor)
                NotesSection(notes: $notes, iconColor: iconColor)
                    .onTapGesture {
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    }
            }
            .scrollIndicators(.hidden)
            
            SubmitButton(action: submitForm, iconColor: iconColor)
        }
        .padding()
        .navigationTitle("Create Task")
    }
    
    func submitForm() {
        // Handle form submission
        print("*********************")
        print("Title: \(title)")
        print("Notes: \(notes)")
        print("ShowIconPicker: \(showIconPicker)")
        print("SelectediconName: \(selectedIconName)")
        print("IconColor: \(iconColor.toRGBA!)")
        print("DueDate: \(dueDate)")
        print("isTime: \(isTime)")
        print("repeatOption: \(repeatOption)")
    }
    
    
}



struct TaskTitleSection: View {
    @Binding var title: String
    @Binding var showIconPicker: Bool
    @Binding var selectedIconName: String
    @Binding var iconColor: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Image(systemName: "pencil")
                    .foregroundColor(iconColor)
                Text("Title:")
                    .font(.title2)
                    .fontWeight(.bold)
                Spacer()
            }
            
            HStack {
                TextField("Enter title", text: $title)
                    .padding(.leading, 4)
                    .padding(.bottom, 8)
                    .overlay(
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(Color.primary)
                            .padding(.leading, 4),
                        alignment: .bottom
                    )
                    .padding(.bottom, 15)
                
                Button(action: {
                    showIconPicker.toggle()
                }) {
                    Image(systemName: selectedIconName)
                        .frame(width: 45, height: 45)
                        .foregroundStyle(iconColor)
                        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 10.0))
                }
                .padding(.bottom, 15)
                .popover(isPresented: $showIconPicker) {
                    IconPickerView(selectedIcon: $selectedIconName, iconColor: $iconColor)
                }
            }
        }
    }
}

struct DueDateSection: View {
    @Binding var dueDate: Date
    @Binding var isTime: Bool
    @State var selectDate = false
    @State var showCalendar = false
    var iconColor: Color
    
    var body: some View {
        // Label section
        VStack(alignment: .center, spacing: 10) {
            HStack {
                Image(systemName: "calendar")
                    .foregroundColor(iconColor)
                Text("Date:")
                    .font(.title2)
                    .fontWeight(.bold)
                
                Spacer()
                
                Image(systemName: "clock")
                    .foregroundStyle(iconColor)
                Text("Time")
                    .font(.title2)
                    .fontWeight(.bold)
                Toggle(isOn: $isTime) {}
                    .toggleStyle(SwitchToggleStyle(tint: iconColor))
                    .scaleEffect(0.8)
                    .frame(width: 35)
                    .padding(.trailing, 15)
            }
            
            // Date Display and calendar callup
            VStack {
                Button(action: {showCalendar.toggle()}){
                    Text("\(dueDateFormatter(date: dueDate))")
                        .font(.title2)
                        .fontWeight(.medium)
                        .padding(15)
                        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 10))
                        .foregroundStyle(Color.primary)
                        .popover(isPresented: $showCalendar) {
                            VStack {
                                DatePicker(
                                    "Select due date",
                                    selection: $dueDate,
                                    displayedComponents: [.date]
                                )
                                .datePickerStyle(GraphicalDatePickerStyle())
                                .tint(iconColor)
                                .labelsHidden()
                                
                                Button(action: {
                                    showCalendar = false
                                }){
                                    Text("Done")
                                        .foregroundStyle(Color.white)
                                        .font(.title)
                                }
                                .padding(10)
                                .background(iconColor)
                                .cornerRadius(10)
                            }
                        }
                }
                
                // Time selection display
                if(isTime) {
                    DatePicker(
                        "Set a time",
                        selection: $dueDate,
                        displayedComponents: [.hourAndMinute]
                    )
                    .tint(iconColor)
                    .labelsHidden()
                }
            }
        }
    }
    
    // Correct date formatter for the display
    func dueDateFormatter(date: Date) -> String {
            let formatter = DateFormatter()
            formatter.dateFormat = "EEEE, MMM d" // This will format the date as "Monday, Jan 1"
            return formatter.string(from: date)
        }
}

struct ColorSection: View {
    @Binding var iconColor: Color
    // Define colors for the circles
    let colors: [Color] = [.blue, .red, .green, .yellow]
    
    // State variable to track the selected color index
    @State private var selectedColorIndex = 0
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "paintpalette")
                    .foregroundColor(iconColor)
                Text("Color:")
                    .font(.title2)
                    .fontWeight(.bold)
                Spacer()
            }
            
            HStack {
                ForEach (0..<4) { index in
                    Circle()
                        .overlay(
                            Group {
                                if index == selectedColorIndex {
                                    Circle()
                                        .stroke(.black, lineWidth: 2)
                                        .frame(width: 22)
                                }
                            }
                        )
                        .frame(width: 30)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 10)
                        .foregroundStyle(index < colors.count ? colors[index] : Color.white)
                        .onTapGesture {
                            withAnimation {
                                selectedColorIndex = index
                                iconColor = colors[selectedColorIndex]
                            }
                        }
                }
                
                ColorPicker("", selection: $iconColor)
                    .labelsHidden() // Hides the label of the color picker
                    .frame(width: 35, height: 35) // Match the circle size
                    .padding(.horizontal, 10)
                    .padding(.vertical, 10)
                    .clipShape(Circle()) // Make the color picker circular
                    .onChange(of: iconColor){
                        if let index = colors.firstIndex(of: iconColor) {
                            selectedColorIndex = index
                        } else {
                            selectedColorIndex = 5
                        }
                    }
            }
            .frame(maxWidth: .infinity)
            .background(Color.clear)
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }
    }
}

struct RepeatSection: View {
    @Binding var repeatOption: Int
    var iconColor: Color
    let selectionsText = ["None", "Daily", "Weekly"]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Image(systemName: "repeat")
                    .foregroundColor(iconColor)
                Text("Repeat:")
                    .font(.title2)
                    .fontWeight(.bold)
                Spacer()
            }
            HStack {
                HStack{
                    ForEach(0..<3){ index in
                        Button(action: {
                            withAnimation{
                                repeatOption = index
                            }
                        }){
                            Text(selectionsText[index])
                                .foregroundStyle(Color.primary)
                                .font(.title3)
                        }
                        .padding()
                        .background(repeatOption == index ? iconColor : Color.clear, in: RoundedRectangle(cornerRadius: 10.0))
                    }
                }
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 10))
            }
            .frame(maxWidth: .infinity)
            .padding(.bottom, 10)
        }
    }
}

struct NotesSection: View {
    @Binding var notes: String
    var iconColor: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Image(systemName: "text.alignleft")
                    .foregroundColor(iconColor)
                Text("Notes:")
                    .font(.title2)
                    .fontWeight(.bold)
                Spacer()
            }
            
            ZStack {
                TextEditor(text: $notes)
                    .padding(2)
                    .border(Color.gray, width: 2)
                    .frame(height: 200)
                    .cornerRadius(3)
                
                if notes.isEmpty {
                    VStack {
                        HStack {
                            Text("Enter notes here...")
                                .foregroundStyle(.tertiary)
                                .padding(.top, 10)
                                .padding(.leading, 8)
                            Spacer()
                        }
                        Spacer()
                    }
                }
            }
        }
    }
}

struct SubmitButton: View {
    let action: () -> Void
    let iconColor: Color
    
    var body: some View {
        Button(action: action) {
            Text("Submit")
                .font(.title2)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, minHeight: 44)
                .background(iconColor)
                .foregroundColor(.white)
                .cornerRadius(10)
        }
    }
}

struct AddTaskView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AddTaskView()
        }
    }
}
