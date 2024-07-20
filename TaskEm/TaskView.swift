import SwiftUI

struct TaskCard: View {
    @Binding var taskData: TaskData
    var saveFunction: Void
    
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
                    saveFunction
                }
        }
    }
}

struct TaskView: View {
    @EnvironmentObject var userStore: UserStore
    
    var body: some View {
        VStack {
            ForEach(userStore.userData.tasks.indices, id: \.self) { index in
                TaskCard(taskData: $userStore.userData.tasks[index],
                         saveFunction:
                            {saveData(userStore: userStore)}()
                )
                    .padding(.vertical)
                    .onTapGesture {
                        userStore.userData.tasks.removeAll{$0.id == userStore.userData.tasks[index].id}
                        saveData(userStore: userStore)
                    }
                
                // Add Divider except after the last item
                if index != userStore.userData.tasks.count - 1 {
                    Divider()
                        .background(Color.white)
                        .padding(.horizontal)
                }
            }
        }
    }
}

struct testingTaskView: View {
    @EnvironmentObject var userStore: UserStore
    var body: some View {
        TaskView()
            .onAppear{
                loadData(userStore: userStore)
            }
    }
}


#Preview{
    testingTaskView()
        .environmentObject(UserStore())
}
