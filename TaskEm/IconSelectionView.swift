import SwiftUI

struct IconPickerView: View {
    @State private var selectedIcon: String?
    
    // Example subset of SF Symbols
    let icons: [String] = {
        var symbols: [String] = []
        let symbolNames = [
            "star", "heart", "flame", "bolt", "moon", "sun.max",
            "cloud", "umbrella", "pencil", "scissors"
        ]
        for name in symbolNames {
            symbols.append(name)
        }
        return symbols
    }()
    
    let columns = [
        GridItem(.adaptive(minimum: 50))
    ]
    
    var body: some View {
        VStack {
            LazyVGrid(columns: columns, spacing: 30) {
                ForEach(icons, id: \.self) { icon in
                    Image(systemName: icon)
                        .resizable()
                        .frame(width: 30, height: 30)
                        .padding(12)
                        .background(selectedIcon == icon ? Color.blue.opacity(0.4) : Color.gray)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .onTapGesture {
                            selectedIcon = icon
                        }
                }
            }
            .padding()
            
            if let selectedIcon = selectedIcon {
                Text("Selected Icon: \(selectedIcon)")
                    .padding()
            }
        }
    }
}

struct IconPickerView_Previews: PreviewProvider {
    static var previews: some View {
        IconPickerView()
    }
}
