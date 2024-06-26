import SwiftUI


class IconDataModel {
    var iconNames: [String] = ["star", "heart", "flame", "bolt", "moon", "sun.max",
        "cloud", "umbrella", "pencil", "scissors"
    ]
    var searchText = ""
    var filteredIcons: [String] {
        if(searchText.isEmpty){
            return iconNames
        }
        else {
            return iconNames.filter{$0.lowercased().contains(searchText.lowercased())}
        }
    }
}
