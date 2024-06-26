import SwiftUI

struct IconPickerView: View {
    @Binding var selectedIcon: String
    @State var viewModel = IconDataModel()
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: Array(repeating: GridItem(), count: 5)) {
                ForEach(viewModel.filteredIcons, id: \.self) { icon in
                    Image(systemName: icon)
                        .font(.title)
                        .padding(10)
                        .onTapGesture {
                            selectedIcon = icon
                        }
                }
            }
            .padding()
        }
    }
}

struct TestIconPicker: View {
    @State private var selectedIcon = "star"
    var body: some View {
        IconPickerView(selectedIcon: $selectedIcon)
    }
}

struct IconPickerView_Previews: PreviewProvider {
    static var previews: some View {
        TestIconPicker()
    }
}
