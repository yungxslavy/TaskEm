import SwiftUI

@main
struct TaskEmApp: App {
    @StateObject private var userStore = UserStore()
    
    var body: some Scene {
        WindowGroup {
            HomeView(selectedDate: Date(), baseDate: Date())
                .environmentObject(userStore)
        }
    }
}
