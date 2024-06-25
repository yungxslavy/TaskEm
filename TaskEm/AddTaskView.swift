
import SwiftUI

struct AddTaskView: View {
    @State private var title: String = ""
    @State private var details: String = ""
    
    let genders = ["Male", "Female"]
    
    var body: some View {
        VStack {
            HStack {
                Text("New Task")
                    .font(.title)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 10)
            }
            Text("Title")
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)
            TextField("Enter title", text: $title).underline()
            Spacer()
        }
        .padding()
        
    }
    
    func submitForm() {
        // Handle form submission
        print("Form submitted")
    }
}


#Preview(){
    AddTaskView()
}
