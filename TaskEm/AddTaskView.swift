import SwiftUI

struct AddTaskView: View {
    @State private var title: String = ""
    @State private var notes: String = ""
    @State private var showIconPicker = false
    @State private var selectedIconName = "star"
    @State private var iconColor = Color.blue
    @State private var dueDate = Date()
    @State private var isTime = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            ScrollView {
                TaskTitleSection(title: $title, showIconPicker: $showIconPicker, selectedIconName: $selectedIconName, iconColor: $iconColor)
                DueDateSection(dueDate: $dueDate, isTime: $isTime, iconColor: iconColor)
                ColorSection(iconColor: $iconColor)
                NotesSection(notes: $notes, iconColor: iconColor)
                    .onTapGesture {
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    }
            }
            .scrollIndicators(.hidden)
            
            Spacer()
            
            SubmitButton(action: submitForm)
        }
        .padding()
        .navigationTitle("Create Task")
    }
    
    func submitForm() {
        // Handle form submission
        print("Date: \(dueDate)")
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
    var iconColor: Color
    
    var body: some View {
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
                    .toggleStyle(SwitchToggleStyle(tint: .blue))
                    .scaleEffect(0.8)
                    .frame(width: 35)
                    .padding(.trailing, 15)
            }
            
            VStack {
                DatePicker(
                    "Select due date",
                    selection: $dueDate,
                    displayedComponents: [.date]
                )
                .datePickerStyle(WheelDatePickerStyle())
                .labelsHidden()
                
                if isTime {
                    DatePicker(
                        "Set a time",
                        selection: $dueDate,
                        displayedComponents: [.hourAndMinute]
                    )
                    .labelsHidden()
                }
            }
        }
    }
}

struct ColorSection: View {
    @Binding var iconColor: Color
    
    var body: some View {
        HStack {
            Image(systemName: "paintpalette")
                .foregroundColor(iconColor)
            Text("Color:")
                .font(.title2)
                .fontWeight(.bold)
            Spacer()
            ColorPicker("", selection: $iconColor)
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
    
    var body: some View {
        Button(action: action) {
            Text("Submit")
                .font(.title2)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, minHeight: 44)
                .background(Color.blue)
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
