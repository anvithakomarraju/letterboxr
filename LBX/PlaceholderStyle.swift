import SwiftUI

struct PlaceholderStyle: ViewModifier {
    var showPlaceholder: Bool
    var placeholder: String
    var placeholderColor: Color
    var textColor: Color

    func body(content: Content) -> some View {
        ZStack(alignment: .leading) {
            if showPlaceholder {
                Text(placeholder)
                    .foregroundColor(placeholderColor)
                    .padding(.leading, 4)
            }
            content
                .foregroundColor(textColor)
                .padding(5)
        }
    }
}

extension View {
    func placeholder(when showPlaceholder: Bool, placeholder: String, placeholderColor: Color, textColor: Color) -> some View {
        self.modifier(PlaceholderStyle(showPlaceholder: showPlaceholder, placeholder: placeholder, placeholderColor: placeholderColor, textColor: textColor))
    }
}
