import SwiftUI

struct SignInView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.white
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Spacer() // Spacer to push content down
                    Image("logo") // Use the name of your image asset here
                        .resizable()
                        .scaledToFit()
                        .frame(width: 500, height: 300) // Adjust the size as needed
                        .padding(.top, -40) // Reduced padding to move the logo closer to the rest of the content
                    
                    VStack(spacing: 15) {
                        // Email TextField
                        TextField("", text: $email)
                            .placeholder(when: email.isEmpty, placeholder: "Email", placeholderColor: .gray, textColor: .black)
                            .padding()
                            .background(Color(white: 0.9)) // Light gray background
                            .cornerRadius(10)
                            .frame(maxWidth: 300)
                        
                        // Password SecureField
                        SecureField("", text: $password)
                            .placeholder(when: password.isEmpty, placeholder: "Password", placeholderColor: .gray, textColor: .black)
                            .padding()
                            .background(Color(white: 0.9)) // Light gray background
                            .cornerRadius(10)
                            .frame(maxWidth: 300)
                        
                        // Sign In Button
                        Button(action: {
                            // Handle sign in action
                        }) {
                            Text("Sign In")
                                .font(.headline)
                                .padding()
                                .foregroundColor(.white)
                                .background(Color(red: 45/255, green: 181/255, blue: 181/255)) // Teal color
                                .cornerRadius(10)
                        }
                        .padding()
                        
                        // Sign Up Navigation Link
                        NavigationLink(destination: SignUpView()) {
                            Text("Don't have an account? Sign Up")
                                .padding(.top, 5) // Adjust padding to move closer to the Sign In button
                                .foregroundColor(Color(red: 45/255, green: 181/255, blue: 181/255)) // Teal color
                        }
                    }
                    .padding(.top, -20) // Move the form closer to the logo
                    
                    Spacer() // Spacer to push content up
                }
                .padding()
            }
            .navigationBarHidden(true) // Hide the navigation bar to remove the title
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
