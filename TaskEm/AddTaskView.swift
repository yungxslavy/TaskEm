import SwiftUI

struct AddTaskView: View {
    @State private var title: String = ""
    @State private var notes: String = ""
    @State private var showIconPicker = false
    @State private var selectedIconName = "lightbulb.max.fill"
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            ScrollView {
                
                // Icon
                HStack {
                    Button(action: {
                        showIconPicker.toggle()
                    }){
                        Image(systemName: selectedIconName)
                            .padding(10)
                            .foregroundStyle(Color.white)
                            .background(Color.blue)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                }
                .padding(.bottom, 15)
                
                // Title
                HStack {
                    Image(systemName: "pencil")
                        .foregroundColor(.blue)
                    Text("Title:")
                        .font(.title2)
                        .fontWeight(.bold)
                    Spacer()
                }
                
                TextField("Enter title", text: $title)
                    .padding(.leading, 10)
                    .padding(.bottom, 8)
                    .overlay(
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(Color.primary)
                            .padding(.leading, 10),
                        alignment: .bottom
                    )
                    .padding(.bottom, 15)
                
                // Details
                HStack {
                    Image(systemName: "text.alignleft")
                        .foregroundColor(.blue)
                    Text("Notes:")
                        .font(.title2)
                        .fontWeight(.bold)
                    Spacer()
                }
                // Detail placeholder overview
                ZStack {
                    TextEditor(text: $notes)
                        .padding(2)
                        .border(Color.gray, width: 2)
                        .frame(height: 200)
                    .cornerRadius(3)
                    
                    if(notes.isEmpty) {
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
            
            Spacer()
            
            Button(action: submitForm) {
                Text("Submit")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, minHeight: 44)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil)
        }
        .padding()
        .navigationTitle("Create Task")
    }
    
    func submitForm() {
        // Handle form submission
        print("Form submitted with title: \(title) and details: \(notes)")
    }
}

struct AddTaskView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AddTaskView()
        }
    }
}
