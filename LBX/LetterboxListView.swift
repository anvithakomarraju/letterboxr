import SwiftUI

struct LetterboxListView: View {
    let tealColor = Color(red: 45/255, green: 181/255, blue: 181/255)
    let darkGrayColor = Color(red: 42/255, green: 45/255, blue: 51/255)
    let lightTealColor = Color(red: 169/255, green: 222/255, blue: 222/255)
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(red: 79/255, green: 85/255, blue: 94/255)
                    .edgesIgnoringSafeArea(.all)
                
                List {
                    Text("Saved Letterbox 1")
                        .foregroundColor(lightTealColor)
                        .listRowBackground(darkGrayColor)
                    Text("Saved Letterbox 2")
                        .foregroundColor(lightTealColor)
                        .listRowBackground(darkGrayColor)
                    Text("Attempted Letterbox 1")
                        .foregroundColor(lightTealColor)
                        .listRowBackground(darkGrayColor)
                    Text("Attempted Letterbox 2")
                        .foregroundColor(lightTealColor)
                        .listRowBackground(darkGrayColor)
                    // Add more items as needed
                }
                .listStyle(InsetGroupedListStyle())
                .background(Color(red: 79/255, green: 85/255, blue: 94/255))
            }
            .navigationBarTitle("Letterbox List", displayMode: .inline)
            .navigationBarItems(leading: EmptyView(), trailing: EmptyView())
            .navigationBarColor(tealColor.uiColor()) // Convert SwiftUI Color to UIColor
        }
    }
}

struct LetterboxListView_Previews: PreviewProvider {
    static var previews: some View {
        LetterboxListView()
    }
}

extension Color {
    func uiColor() -> UIColor {
        let components = self.cgColor?.components
        let r = components?[0] ?? 0
        let g = components?[1] ?? 0
        let b = components?[2] ?? 0
        let a = components?[3] ?? 1
        return UIColor(red: r, green: g, blue: b, alpha: a)
    }
}

extension View {
    func navigationBarColor(_ backgroundColor: UIColor?) -> some View {
        self.modifier(NavigationBarModifier(backgroundColor: backgroundColor))
    }
}

struct NavigationBarModifier: ViewModifier {
    var backgroundColor: UIColor?
    
    init(backgroundColor: UIColor?) {
        self.backgroundColor = backgroundColor
        let coloredAppearance = UINavigationBarAppearance()
        coloredAppearance.configureWithOpaqueBackground()
        coloredAppearance.backgroundColor = backgroundColor
        coloredAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        coloredAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        UINavigationBar.appearance().standardAppearance = coloredAppearance
        UINavigationBar.appearance().compactAppearance = coloredAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
        UINavigationBar.appearance().tintColor = .white
    }
    
    func body(content: Content) -> some View {
        content
    }
}
