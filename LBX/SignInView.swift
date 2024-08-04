import SwiftUI

//git test

struct SignInView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(red: 79/255, green: 85/255, blue: 94/255)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Image("logo") // Use the name of your image asset here
                        .resizable()
                        .scaledToFit()
                        .frame(width: 550, height: 500)
                        .padding(.top, -70) // Adjust padding as needed
                    
                    VStack(spacing: 15) {
                        TextField("", text: $email)
                            .placeholder(when: email.isEmpty, placeholder: "Email", placeholderColor: Color(red: 169/255, green: 222/255, blue: 222/255), textColor: Color(red: 169/255, green: 222/255, blue: 222/255))
                            .padding()
                            .background(Color(red: 42/255, green: 45/255, blue: 51/255)) // Custom RGB color
                            .cornerRadius(10)
                            .frame(maxWidth: 300)
                        SecureField("", text: $password)
                            .placeholder(when: password.isEmpty, placeholder: "Password", placeholderColor: Color(red: 169/255, green: 222/255, blue: 222/255), textColor: Color(red: 169/255, green: 222/255, blue: 222/255))
                            .padding()
                            .background(Color(red: 42/255, green: 45/255, blue: 51/255)) // Custom RGB color
                            .cornerRadius(10)
                            .frame(maxWidth: 300)
                        
                        Button(action: {
                            // Handle sign in action
                        }) {
                            Text("Sign In")
                                .font(.headline)
                                .padding()
                                .foregroundColor(.white)
                                .background(Color(red: 45/255, green: 181/255, blue: 181/255)) // Custom RGB color
                                .cornerRadius(10)
                        }
                        .padding()
                        
                        NavigationLink(destination: SignUpView()) {
                            Text("Don't have an account? Sign Up")
                                .padding(.top, 5) // Adjust padding to move closer to the Sign In button
                                .foregroundColor(Color(red: 45/255, green: 181/255, blue: 181/255)) // Custom RGB color
                        }
                    }
                    .offset(y: -110) // Move the entire VStack up by 90 points
                    
                    Spacer() // Pushes the content to the top
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
