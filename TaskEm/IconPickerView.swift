import SwiftUI

struct IconPickerView: View {
    @Binding var selectedIcon: String
    @Binding var iconColor: Color
    @State var viewModel = IconDataModel()
    
    var body: some View {
        NavigationStack {
            HStack {
                Text("holder")
                    .foregroundStyle(Color.clear)
                    .frame(maxHeight: 1)
            }
            .frame(maxHeight: 1)
            .searchable(text: $viewModel.searchText)
            ScrollView {
                LazyVGrid(columns: Array(repeating: GridItem(), count: 5)) {
                    ForEach(viewModel.filteredIcons, id: \.self) { icon in
                        Image(systemName: icon)
                            .font(.title)
                            .padding(10)
                            .foregroundStyle(selectedIcon == icon ? iconColor : Color.primary)
                            .onTapGesture {
                                selectedIcon = icon
                            }
                    }
                    .frame(width: 60, height: 60)
                    .background(.ultraThinMaterial, in:RoundedRectangle(cornerRadius: 10))
                    
                }
                .padding()
            }
        }
        .navigationTitle("Icons")
    }
}

struct TestIconPicker: View {
    @State private var selectedIcon = "star"
    @State private var iconColor = Color.red
    var body: some View {
        IconPickerView(selectedIcon: $selectedIcon, iconColor: $iconColor)
    }
}

struct IconPickerView_Previews: PreviewProvider {
    static var previews: some View {
        TestIconPicker()
    }
}
