import SwiftUI

struct TestDataStore: View {
    @StateObject var userStore = UserStore()
    @State var count = 0
    var body: some View {
        VStack{
            Text("Sample Data Count: \(count)")
            Button(action: {
                let sample = TaskData.sampleData[0]
                userStore.userData.tasks.append(sample)
                Task{
                    do {
                        try await userStore.save()
                        print("Saved data")
                    }
                    catch {
                        print("Failed to load data: \(error)")
                    }
                }
            }){
                Text("Save Random Data")
            }
            
            Button(action: {
                _ = userStore.userData.tasks.popLast()
                Task{
                    do {
                        try await userStore.save()
                        print("Saved data")
                        print("\(userStore.userData.tasks[0])")
                    }
                    catch {
                        print("Failed to load data: \(error)")
                    }
                }
            }){
                Text("Delete Last Task Entry")
            }
        }
        .onAppear{
            Task{
                do {
                    try await userStore.load()
                    count = userStore.userData.tasks.count
                }
                catch {
                    print("Failed to load data: \(error)")
                }
            }
        }
    }
}


struct TestDataStorePreview: PreviewProvider {
    static var previews: some View {
        TestDataStore()
    }
}
