import SwiftUI
import Observation
@Observable
class IconDataModel {
    var iconNames: [String] = [
        "star", "heart", "flame", "bolt", "moon", "sun.max",
        "cloud", "umbrella", "pencil", "scissors",
        "paperclip", "magnifyingglass", "trash", "folder", "doc",
        "book", "bookmark", "tag", "bell", "alarm",
        "calendar", "camera", "photo", "video", "music.note",
        "speaker", "headphones", "mic", "phone", "envelope",
        "bubble.left", "bubble.right", "flag", "globe", "house",
        "car", "bicycle", "airplane", "bus",
        "location", "map", "clock", "stopwatch",
        "timer", "battery.100", "battery.75", "battery.50", "battery.25",
        "battery.0", "lightbulb", "gear", "wrench", "hammer",
        "screwdriver", "ruler", "paintbrush", "paintpalette", "scalemass",
        "thermometer", "waveform.path.ecg", "stethoscope", "bandage", "cross",
        "leaf", "tree", "pawprint", "fish",
        "tortoise", "hare", "ant", "ladybug",
        "bird", "snowflake", "wind",
        "drop", "waveform", "waveform.circle", "bolt.circle", "bolt.slash",
        "moon.circle", "cloud.rain", "cloud.snow", "cloud.bolt", "cloud.sun",
        "cloud.moon", "tornado", "hurricane", "smoke",
        "umbrella.fill", "pencil.tip", "pencil.circle", "scissors.circle", "scissors.badge.ellipsis",
        "paperclip.circle", "paperclip.badge.ellipsis", "trash.circle", "folder.circle", "folder.badge.plus"
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
