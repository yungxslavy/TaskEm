import SwiftUI

struct TaskData: Identifiable {
    let id: UUID
    var name: String
    var icon: Image
    var iconColor: Color
    var dueDate: Date
    var isComplete: Bool
    
    init(id: UUID = UUID(), name: String, icon: Image, iconColor: Color, dueDate: Date, isComplete: Bool = false){
        self.id = id
        self.name = name
        self.icon = icon
        self.iconColor = iconColor
        self.dueDate = dueDate
        self.isComplete = isComplete
    }
}

extension TaskData {
    static var sampleData: [TaskData] {
        [
            TaskData(name: "Take Out Trash But this one is significantly longer than usual for your title but now we just got even longer like how long can a title genuinly be ?? jeuss", icon: Image(systemName: "trash"), iconColor: .red, dueDate: Calendar.current.date(byAdding: .day, value: 1, to: Date())!),
            TaskData(name: "Finish Report", icon: Image(systemName: "doc.text"), iconColor: .blue, dueDate: Calendar.current.date(byAdding: .day, value: 3, to: Date())!, isComplete: true),
            TaskData(name: "Grocery Shopping", icon: Image(systemName: "cart"), iconColor: .green, dueDate: Calendar.current.date(byAdding: .day, value: 2, to: Date())!),
            TaskData(name: "Call Plumber", icon: Image(systemName: "phone"), iconColor: .orange, dueDate: Calendar.current.date(byAdding: .day, value: 5, to: Date())!),
            TaskData(name: "Take Out Trash But this one is significantly longer than usual for your title but now we just got even longer like how long can a title genuinly be ?? jeuss", icon: Image(systemName: "trash"), iconColor: .red, dueDate: Calendar.current.date(byAdding: .day, value: 1, to: Date())!),
            TaskData(name: "Finish Report", icon: Image(systemName: "doc.text"), iconColor: .blue, dueDate: Calendar.current.date(byAdding: .day, value: 3, to: Date())!, isComplete: true),
            TaskData(name: "Grocery Shopping", icon: Image(systemName: "cart"), iconColor: .green, dueDate: Calendar.current.date(byAdding: .day, value: 2, to: Date())!),
            TaskData(name: "Call Plumber", icon: Image(systemName: "phone"), iconColor: .orange, dueDate: Calendar.current.date(byAdding: .day, value: 5, to: Date())!),
            TaskData(name: "Take Out Trash But this one is significantly longer than usual for your title but now we just got even longer like how long can a title genuinly be ?? jeuss", icon: Image(systemName: "trash"), iconColor: .red, dueDate: Calendar.current.date(byAdding: .day, value: 1, to: Date())!),
            TaskData(name: "Finish Report", icon: Image(systemName: "doc.text"), iconColor: .blue, dueDate: Calendar.current.date(byAdding: .day, value: 3, to: Date())!, isComplete: true),
            TaskData(name: "Grocery Shopping", icon: Image(systemName: "cart"), iconColor: .green, dueDate: Calendar.current.date(byAdding: .day, value: 2, to: Date())!),
            TaskData(name: "Call Plumber", icon: Image(systemName: "phone"), iconColor: .orange, dueDate: Calendar.current.date(byAdding: .day, value: 5, to: Date())!)
        ]
    }
}
