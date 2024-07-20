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
    var title: String               // Title of the task
    var iconName: String            // Icon name as a string
    var iconColorRGBA: ColorRGBA    // Only way to encode a color ?? fuck you apple 
    var dueDate: Date               // Date the original task is intended to be completed
    var isTime: Bool                // Has specified time, else just the day
    var repeatOption: Int           // 0 = never, 1 = daily, 2 = weekly
    var reminderDiffSecs: [Int]     // How many different seconds before due date should user be reminded
    var notes: String               // String for notes provided by the user e
    var isComplete: Bool            // Boolean that determines completeness of task
    
    init(id: UUID = UUID(), title: String, iconName: String, iconColor: Color, dueDate: Date = Date(), isTime: Bool = false, repeatOption: Int = 0, reminderDiffSecs: [Int] = [], notes: String = "", isComplete: Bool = false) {
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
