import SwiftUI

struct AddTaskView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var showIconPicker = false
    @EnvironmentObject var userStore: UserStore
    @State private var task = TaskData(
        title: "",
        iconName: "star",
        iconColor: Color.blue
    )
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            ScrollView {
                TaskTitleSection(task: $task, showIconPicker: $showIconPicker)
                DueDateSection(task: $task)
                ColorSection(task: $task)
                RepeatSection(task: $task, iconColor: task.iconColorRGBA.color)
                NotesSection(task: $task, iconColor: task.iconColorRGBA.color)
                    .onTapGesture {
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    }
            }
            .scrollIndicators(.hidden)
            
            SubmitButton(action: submitForm, iconColor: task.iconColorRGBA.color)
        }
        .padding()
        .navigationTitle("Create Task")
    }
    
    func submitForm() {
        // Handle form submission
        print("*********************")
        print("Title: \(task.title)")
        print("Notes: \(task.notes)")
        print("IconName: \(task.iconName)")
        print("IconColor: \(task.iconColorRGBA)")
        print("DueDate: \(task.dueDate)")
        print("isTime: \(task.isTime)")
        print("repeatOption: \(task.repeatOption)")
        loadData(userStore: userStore)
        userStore.userData.tasks.append(task)
        saveData(userStore: userStore)
        self.presentationMode.wrappedValue.dismiss()
    }
}



struct TaskTitleSection: View {
    @Binding var task: TaskData
    @Binding var showIconPicker: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Image(systemName: "pencil")
                    .foregroundColor(task.iconColorRGBA.color)
                Text("Title:")
                    .font(.title2)
                    .fontWeight(.bold)
                Spacer()
            }
            
            HStack {
                TextField("Enter title", text: $task.title)
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
                    Image(systemName: task.iconName)
                        .frame(width: 45, height: 45)
                        .foregroundStyle(task.iconColorRGBA.color)
                        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 10.0))
                }
                .padding(.bottom, 15)
                .popover(isPresented: $showIconPicker) {
                    IconPickerView(selectedIcon: $task.iconName, iconColor: task.iconColorRGBA.color)
                }
            }
        }
    }
}

struct DueDateSection: View {
    @State var selectDate = false
    @State var showCalendar = false
    @Binding var task: TaskData
    
    var body: some View {
        // Label section
        VStack(alignment: .center, spacing: 10) {
            HStack {
                Image(systemName: "calendar")
                    .foregroundColor(task.iconColorRGBA.color)
                Text("Date:")
                    .font(.title2)
                    .fontWeight(.bold)
                
                Spacer()
                
                Image(systemName: "clock")
                    .foregroundStyle(task.iconColorRGBA.color)
                Text("Time")
                    .font(.title2)
                    .fontWeight(.bold)
                Toggle(isOn: $task.isTime) {}
                    .toggleStyle(SwitchToggleStyle(tint: task.iconColorRGBA.color))
                    .scaleEffect(0.8)
                    .frame(width: 35)
                    .padding(.trailing, 15)
            }
            
            // Date Display and calendar callup
            VStack {
                Button(action: {showCalendar.toggle()}){
                    Text("\(dueDateFormatter(date: task.dueDate))")
                        .font(.title2)
                        .fontWeight(.medium)
                        .padding(15)
                        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 10))
                        .foregroundStyle(Color.primary)
                        .popover(isPresented: $showCalendar) {
                            VStack {
                                DatePicker(
                                    "Select due date",
                                    selection: $task.dueDate,
                                    displayedComponents: [.date]
                                )
                                .datePickerStyle(GraphicalDatePickerStyle())
                                .tint(task.iconColorRGBA.color)
                                .labelsHidden()
                                
                                Button(action: {
                                    showCalendar = false
                                }){
                                    Text("Done")
                                        .foregroundStyle(Color.white)
                                        .font(.title)
                                }
                                .padding(10)
                                .background(task.iconColorRGBA.color)
                                .cornerRadius(10)
                            }
                        }
                }
                
                // Time selection display
                if(task.isTime) {
                    DatePicker(
                        "Set a time",
                        selection: $task.dueDate,
                        displayedComponents: [.hourAndMinute]
                    )
                    .tint(task.iconColorRGBA.color)
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
    @State private var selectedColorIndex = 0
    @State private var iconColor = Color.blue
    @Binding var task: TaskData
    
    // Define colors for the circles
    let colors: [Color] = [.blue, .red, .green, .yellow]
    
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
                        withAnimation {
                            task.iconColorRGBA = ColorRGBA(color: iconColor)
                        }
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
    @Binding var task: TaskData
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
                                task.repeatOption = index
                            }
                        }){
                            Text(selectionsText[index])
                                .foregroundStyle(Color.primary)
                                .font(.title3)
                        }
                        .padding()
                        .background(task.repeatOption == index ? iconColor : Color.clear, in: RoundedRectangle(cornerRadius: 10.0))
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
    @Binding var task: TaskData
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
                TextEditor(text: $task.notes)
                    .padding(2)
                    .border(Color.gray, width: 2)
                    .frame(height: 200)
                    .cornerRadius(3)
                
                if task.notes.isEmpty {
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
                .environmentObject(UserStore())
        }
    }
}
