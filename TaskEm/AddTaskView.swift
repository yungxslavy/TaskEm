import SwiftUI

struct AddTaskView: View {
    @State private var title: String = ""
    @State private var details: String = ""
    @FocusState private var textfieldFocused: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
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
                Text("Details:")
                    .font(.title2)
                    .fontWeight(.bold)
                Spacer()
            }
            
            TextEditor(text: $details)
                .padding()
                .border(Color.gray, width: 1)
                .frame(height: 200)
            
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
        .padding()
        .navigationTitle("Create Task")
    }
    
    func submitForm() {
        // Handle form submission
        print("Form submitted with title: \(title) and details: \(details)")
    }
}

struct AddTaskView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AddTaskView()
        }
    }
}
