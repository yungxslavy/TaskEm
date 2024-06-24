import SwiftUI

struct SettingsPageView: View {
    @State private var notificationsEnabled = true
    @State private var selectedTheme = "Light"
    @State private var soundEnabled = true
    
    let themes = ["Light", "Dark", "System"]
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("General")) {
                    Toggle(isOn: $notificationsEnabled) {
                        Text("Enable Notifications")
                    }
                    
                    Picker(selection: $selectedTheme, label: Text("App Theme")) {
                        ForEach(themes, id: \.self) { theme in
                            Text(theme)
                        }
                    }
                    
                    Toggle(isOn: $soundEnabled) {
                        Text("Enable Sound")
                    }
                }
                
                Section(header: Text("Account")) {
                    NavigationLink(destination: AccountDetailsView()) {
                        Text("Account Details")
                    }
                    
                    NavigationLink(destination: ChangePasswordView()) {
                        Text("Change Password")
                    }
                }
                
                Section {
                    Button(action: {
                        // Add logout functionality here
                    }) {
                        Text("Log Out")
                            .foregroundColor(.red)
                    }
                }
            }
            .navigationBarTitle("Settings")
        }
    }
}

struct AccountDetailsView: View {
    var body: some View {
        Text("Account Details")
            .navigationBarTitle("Account Details", displayMode: .inline)
    }
}

struct ChangePasswordView: View {
    var body: some View {
        Text("Change Password")
            .navigationBarTitle("Change Password", displayMode: .inline)
    }
}

#Preview(){
    SettingsPageView()
}
