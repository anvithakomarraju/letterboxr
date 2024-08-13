import SwiftUI

extension View {
    func inputPlaceholder(
        when shouldShow: Bool,
        placeholder: String,
        placeholderColor: Color,
        textColor: Color
    ) -> some View {
        ZStack(alignment: .leading) {
            if shouldShow {
                Text(placeholder)
                    .foregroundColor(placeholderColor)
                    .padding(.leading, 8)
            }
            self
                .foregroundColor(textColor)
                .padding(.leading, 8)
        }
    }
}

struct UserProfileView: View {
    @State private var profileImage: UIImage? = UIImage(named: "temppfp") // Placeholder image
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var phoneNumber: String = ""
    @State private var accountCreatedDate: Date = Date() // This should be the date the account was created
    @State private var showChangePassword = false // State to show/hide change password view
    @State private var letterboxes: [Letterbox] = [] // Define letterboxes

    let tealColor = Color(red: 45/255, green: 181/255, blue: 181/255) // Teal color used for the "Change Password" button

    var body: some View {
        NavigationView {
            ZStack {
                Color.white
                    .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 20) {
                    // Profile Picture
                    if let profileImage = profileImage {
                        Image(uiImage: profileImage)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 150, height: 150)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(tealColor, lineWidth: 4)) // Use teal color
                            .shadow(radius: 10)
                            .onTapGesture {
                                // Handle profile picture change
                            }
                    }
                    
                    // Account Creation Date
                    Text("Letterboxr since \(formattedDate(accountCreatedDate))")
                        .foregroundColor(.black) // Use black for text color on white background
                        .font(.headline)
                    
                    // Personal Details
                    VStack(spacing: 15) {
                        TextField("", text: $name)
                            .inputPlaceholder(when: name.isEmpty, placeholder: "Name", placeholderColor: .gray, textColor: .black)
                            .padding()
                            .background(Color(white: 0.9)) // Light gray background
                            .cornerRadius(10)
                            .frame(maxWidth: 300)
                        
                        TextField("", text: $email)
                            .inputPlaceholder(when: email.isEmpty, placeholder: "Email", placeholderColor: .gray, textColor: .black)
                            .padding()
                            .background(Color(white: 0.9)) // Light gray background
                            .cornerRadius(10)
                            .frame(maxWidth: 300)
                        
                        TextField("", text: $phoneNumber)
                            .inputPlaceholder(when: phoneNumber.isEmpty, placeholder: "Phone Number", placeholderColor: .gray, textColor: .black)
                            .padding()
                            .background(Color(white: 0.9)) // Light gray background
                            .cornerRadius(10)
                            .frame(maxWidth: 300)
                        
                        Button(action: {
                            self.showChangePassword = true
                        }) {
                            Text("Change Password")
                                .font(.headline)
                                .padding()
                                .foregroundColor(.white)
                                .background(tealColor) // Use teal color
                                .cornerRadius(10)
                        }
                    }
                    
                    Spacer() // Pushes the content to the top

                    // Bottom Menu
                    HStack {
                        Spacer()
                        NavigationLink(destination: LetterboxesView()) { // Link to Letterboxes view
                            Image(systemName: "magnifyingglass.circle.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 40, height: 40)
                                .foregroundColor(tealColor)
                        }
                        Spacer()
                        NavigationLink(destination: MapContainerView(letterboxes: letterboxes.map { (boxName: $0.boxName, location: $0.location) })) { // Correctly pass letterboxes to MapView
                                Image(systemName: "map.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 40, height: 40)
                                    .foregroundColor(tealColor)
                        }
                        Spacer()
                        NavigationLink(destination: UserProfileView()) {
                            if let profileImage = profileImage {
                                Image(uiImage: profileImage)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 40, height: 40)
                                    .clipShape(Circle())
                                    .overlay(Circle().stroke(tealColor, lineWidth: 1))
                                    .shadow(radius: 5)
                            } else {
                                Image(systemName: "person.crop.circle.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 40, height: 40)
                                    .foregroundColor(tealColor)
                            }
                        }
                        Spacer()
                        NavigationLink(destination: Text("Leaderboard")) {
                            Image(systemName: "trophy.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 40, height: 40)
                                .foregroundColor(tealColor)
                        }
                        Spacer()
                        NavigationLink(destination: LetterboxListView()) {
                            Image(systemName: "list.bullet")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 40, height: 40)
                                .foregroundColor(tealColor)
                        }
                        Spacer()
                    }
                    .padding()
                }
                .padding()
                
                if showChangePassword {
                    ChangePasswordView()
                        .transition(.move(edge: .bottom))
                        .animation(.easeInOut)
                }
            }
            .navigationBarHidden(true) // Hide the navigation bar to remove the title
        }
        .navigationBarBackButtonHidden(true)
    }

    // Helper function to format the date
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter.string(from: date)
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView()
    }
}
