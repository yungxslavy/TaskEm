import SwiftUI


class UserStore: ObservableObject {
    @Published var userData: UserData = UserData()
    
    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory,
                                    in: .userDomainMask,
                                    appropriateFor: nil,
                                    create: false)
        .appendingPathComponent("userData.data")
    }
    
    func load() async throws {
        let fileURL = try UserStore.fileURL()
        guard let data = try? Data(contentsOf: fileURL) else { return }
        let decoder = JSONDecoder()
        let userData = try decoder.decode(UserData.self, from: data)
        await MainActor.run {
            self.userData = userData
        }
    }
    
    func save() async throws {
        let fileURL = try UserStore.fileURL()
        let encoder = JSONEncoder()
        let data = try encoder.encode(userData)
        try data.write(to: fileURL)
    }
}
