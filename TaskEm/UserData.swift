import Foundation

// Define UserData
struct UserData: Identifiable, Codable {
    let id: UUID
    var tasks: [TaskData]

    init(id: UUID = UUID(), tasks: [TaskData] = []) {
        self.id = id
        self.tasks = tasks
    }
}

extension UserData {
    static var sampleData: [TaskData] {
        [
            TaskData(title: "Take Out Trash", iconName: "trash", iconColor: .red, isTime: true),
            TaskData(title: "Finish Report", iconName: "doc.text", iconColor: .blue, dueDate: Calendar.current.date(byAdding: .day, value: 3, to: Date())!, isComplete: true)
        ]
    }
}
