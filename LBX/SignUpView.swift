import SwiftUI

struct SignUpView: View {
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var dateOfBirth: Date = Date()
    
    var body: some View {
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
                    
                    DatePicker("Date of Birth", selection: $dateOfBirth, displayedComponents: .date)
                        .datePickerStyle(CompactDatePickerStyle())
                        .padding()
                        .background(Color(red: 42/255, green: 45/255, blue: 51/255)) // Custom RGB color
                        .foregroundColor(Color(red: 169/255, green: 222/255, blue: 222/255)) // Custom text color
                        .cornerRadius(10)
                        .frame(maxWidth: 300)
                    
                    NavigationLink(destination: HomeView(userName: name)) {
                        Text("Sign Up")
                            .font(.headline)
                            .padding()
                            .foregroundColor(.white)
                            .background(Color(red: 45/255, green: 181/255, blue: 181/255)) // Custom RGB color
                            .cornerRadius(10)
                    }
                    .padding()
                }
                .offset(y: -110) // Move the entire VStack up by 90 points
                
                Spacer() // Pushes the content to the top
            }
            .padding()
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
