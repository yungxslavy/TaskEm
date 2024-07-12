import SwiftUI

struct ColorRGBA: Codable {
    var red: CGFloat
    var green: CGFloat
    var blue: CGFloat
    var alpha: CGFloat
    
    init(color: Color) {
        let uiColor = UIColor(color)
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        uiColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        self.red = red
        self.green = green
        self.blue = blue
        self.alpha = alpha
    }
    
    var color: Color {
        Color(red: red, green: green, blue: blue, opacity: alpha)
    }
}


struct TaskData: Identifiable, Codable {
    let id: UUID
    var title: String
    var iconName: String
    var iconColorRGBA: ColorRGBA
    var dueDate: Date
    var isTime: Bool
    var repeatOption: Int
    var reminderDiffSecs: [Int]?
    var notes: String
    var isComplete: Bool
    
    init(id: UUID = UUID(), title: String, iconName: String, iconColor: Color, dueDate: Date = Date(), isTime: Bool = false, repeatOption: Int = 0, reminderDiffSecs: [Int]? = nil, notes: String = "", isComplete: Bool = false) {
        self.id = id
        self.title = title
        self.iconName = iconName
        self.iconColorRGBA = ColorRGBA(color: iconColor)
        self.dueDate = dueDate
        self.isTime = isTime
        self.repeatOption = repeatOption
        self.reminderDiffSecs = reminderDiffSecs
        self.notes = notes
        self.isComplete = isComplete
    }
    
    var icon: Image {
        Image(systemName: iconName)
    }
}

extension TaskData {
    static var sampleData: [TaskData] {
        [
            TaskData(title: "Take Out Trash", iconName: "trash", iconColor: .red, isTime: true),
            TaskData(title: "Finish Report", iconName: "doc.text", iconColor: .blue, dueDate: Calendar.current.date(byAdding: .day, value: 3, to: Date())!, isComplete: true),
            TaskData(title: "Grocery Shopping", iconName: "cart", iconColor: .green, dueDate: Calendar.current.date(byAdding: .day, value: 2, to: Date())!),
            TaskData(title: "Call Plumber", iconName: "phone", iconColor: .orange, dueDate: Calendar.current.date(byAdding: .day, value: 5, to: Date())!)
        ]
    }
}
