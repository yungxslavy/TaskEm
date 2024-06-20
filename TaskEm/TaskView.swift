import SwiftUI

struct TaskCard: View {
    @Binding var taskData: TaskData
    
    var body: some View {
        HStack(spacing: 10) {
            // Task Icon
            taskData.icon
                .foregroundStyle(taskData.iconColor)
                .frame(minWidth: 30)
            // Task Name
            Text(taskData.name)
                .font(.headline)
            // Spacer
            Spacer()
            // Due Date Time
            Text("\(taskData.dueDate.formatted(date: .omitted, time: .shortened))")
                .font(.subheadline)
            Image(systemName: taskData.isComplete ? "checkmark.square" : "square")
                .foregroundStyle(taskData.iconColor)
                .onTapGesture {
                    taskData.isComplete.toggle()
                }
            
        }
    }
}

struct TaskView: View {
    @State var taskData = TaskData.sampleData
    
    var body: some View {
        VStack {
            ForEach(taskData.indices, id: \.self) { index in
                TaskCard(taskData: $taskData[index])
                    .padding(.vertical)
                
                // Add Divider except after the last item
                if index != taskData.count - 1 {
                    Divider()
                        .background(Color.white) // Customize the color of the divider
                        .padding(.horizontal)
                }
            }
        }
    }
}



#Preview{
    TaskView()
}
