import SwiftUI

struct TaskCard: View {
    @Binding var taskData: TaskData
    
    var body: some View {
        HStack(spacing: 10) {
            // Task Icon
            taskData.icon
                .foregroundStyle(taskData.iconColorRGBA.color)
                .frame(minWidth: 30)
            // Task Name
            Text(taskData.title)
                .font(.headline)
                .strikethrough(taskData.isComplete)
            // Spacer
            Spacer()
            // Due Date Time
            if(taskData.isTime){
                Text("\(taskData.dueDate.formatted(date: .omitted, time: .shortened))")
                    .font(.subheadline)
                    .strikethrough(taskData.isComplete)
            }
            Image(systemName: taskData.isComplete ? "checkmark.square" : "square")
                .imageScale(.large)
                .foregroundStyle(taskData.iconColorRGBA.color)
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
                    .onTapGesture {
                        print(index)
                    }
                
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
