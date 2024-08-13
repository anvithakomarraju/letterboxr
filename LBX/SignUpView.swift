import SwiftUI

struct SignUpView: View {
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var dateOfBirth: Date = Date()
    
    var body: some View {
        ZStack {
            Color.white
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer() // Spacer to push content down

                Image("logo") // Use the name of your image asset here
                    .resizable()
                    .scaledToFit()
                    .frame(width: 500, height: 300) // Adjust the size as needed
                    .padding(.top, -20) // Adjust padding as needed
                
                VStack(spacing: 15) {
                    // Name TextField
                    ZStack(alignment: .leading) {
                        if name.isEmpty {
                            Text("Name")
                                .foregroundColor(Color.gray)
                                .padding(.leading, 8)
                        }
                        TextField("", text: $email)
                            .placeholder(when: email.isEmpty, placeholder: "Name", placeholderColor: .gray, textColor: .black)
                            .padding()
                            .background(Color(white: 0.9)) // Light gray background
                            .cornerRadius(10)
                            .frame(maxWidth: 300)
                    }
                    
                    // Email TextField
                    ZStack(alignment: .leading) {
                        if email.isEmpty {
                            Text("Email")
                                .foregroundColor(Color.gray)
                                .padding(.leading, 8)
                        }
                        TextField("", text: $email)
                            .placeholder(when: email.isEmpty, placeholder: "Email", placeholderColor: .gray, textColor: .black)
                            .padding()
                            .background(Color(white: 0.9)) // Light gray background
                            .cornerRadius(10)
                            .frame(maxWidth: 300)
                    }
                    
                    // DatePicker for Date of Birth
                    DatePicker("Date of Birth", selection: $dateOfBirth, displayedComponents: .date)
                        .datePickerStyle(CompactDatePickerStyle())
                        .padding()
                        .background(Color(white: 0.9)) // Light gray background
                        .cornerRadius(10)
                        .frame(maxWidth: 300)
                    
                    // Sign Up Button
                    NavigationLink(destination: HomeView(userName: name)) {
                        Text("Sign Up")
                            .font(.headline)
                            .padding()
                            .foregroundColor(.white)
                            .background(Color(red: 45/255, green: 181/255, blue: 181/255)) // Teal color
                            .cornerRadius(10)
                    }
                    .padding()
                }
                .padding(.top, -20) // Move the form closer to the logo
                
                Spacer() // Spacer to push content up
            }
            .padding()
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
