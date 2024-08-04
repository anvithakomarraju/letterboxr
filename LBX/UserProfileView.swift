import SwiftUI

struct UserProfileView: View {
    @State private var profileImage: UIImage? = UIImage(named: "temppfp") // Placeholder image
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var phoneNumber: String = ""
    @State private var accountCreatedDate: Date = Date() // This should be the date the account was created
    @State private var showChangePassword = false // State to show/hide change password view

    let tealColor = Color(red: 45/255, green: 181/255, blue: 181/255) // Teal color used for the "Change Password" button

    var body: some View {
        NavigationView {
            ZStack {
                Color(red: 79/255, green: 85/255, blue: 94/255)
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
                        .foregroundColor(tealColor) // Use teal color
                        .font(.headline)
                    
                    // Personal Details
                    VStack(spacing: 15) {
                        TextField("", text: $name)
                            .placeholder(when: name.isEmpty, placeholder: "Name", placeholderColor: Color(red: 169/255, green: 222/255, blue: 222/255), textColor: Color(red: 169/255, green: 222/255, blue: 222/255))
                            .padding()
                            .background(Color(red: 42/255, green: 45/255, blue: 51/255)) // Custom RGB color
                            .cornerRadius(10)
                            .frame(maxWidth: 300)
                        
                        TextField("", text: $email)
                            .placeholder(when: email.isEmpty, placeholder: "Email", placeholderColor: Color(red: 169/255, green: 222/255, blue: 222/255), textColor: Color(red: 169/255, green: 222/255, blue: 222/255))
                            .padding()
                            .background(Color(red: 42/255, green: 45/255, blue: 51/255)) // Custom RGB color
                            .cornerRadius(10)
                            .frame(maxWidth: 300)
                        
                        TextField("", text: $phoneNumber)
                            .placeholder(when: phoneNumber.isEmpty, placeholder: "Phone Number", placeholderColor: Color(red: 169/255, green: 222/255, blue: 222/255), textColor: Color(red: 169/255, green: 222/255, blue: 222/255))
                            .padding()
                            .background(Color(red: 42/255, green: 45/255, blue: 51/255)) // Custom RGB color
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
                        NavigationLink(destination: Text("Search for Letterboxes")) {
                            Image(systemName: "magnifyingglass.circle.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 40, height: 40)
                                .foregroundColor(tealColor)
                        }
                        Spacer()
                        NavigationLink(destination: MapView()) {
                            Image(systemName: "map.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 40, height: 40)
                                .foregroundColor(tealColor)
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
