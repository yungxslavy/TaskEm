import Foundation


struct UserData: Identifiable, Codable {
    let id: UUID
    var tasks: [TaskData]?

    init(id: UUID = UUID(), tasks: [TaskData]? = nil) {
        self.id = id
        self.tasks = tasks
    }
}
