import SwiftUI

struct ChangePasswordView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var oldPassword: String = ""
    @State private var newPassword: String = ""
    @State private var confirmPassword: String = ""
    
    let textColor = Color(red: 169/255, green: 222/255, blue: 222/255) // Light teal color

    var body: some View {
        VStack(spacing: 20) {
            Text("Change Password")
                .font(.headline)
                .padding()
                .foregroundColor(textColor) // Use light teal color
            
            SecureField("", text: $oldPassword)
                .placeholder(when: oldPassword.isEmpty, placeholder: "Old Password", placeholderColor: textColor, textColor: textColor)
                .padding()
                .background(Color(red: 42/255, green: 45/255, blue: 51/255)) // Custom RGB color
                .cornerRadius(10)
                .frame(maxWidth: 300)
            
            SecureField("", text: $newPassword)
                .placeholder(when: newPassword.isEmpty, placeholder: "New Password", placeholderColor: textColor, textColor: textColor)
                .padding()
                .background(Color(red: 42/255, green: 45/255, blue: 51/255)) // Custom RGB color
                .cornerRadius(10)
                .frame(maxWidth: 300)
            
            SecureField("", text: $confirmPassword)
                .placeholder(when: confirmPassword.isEmpty, placeholder: "Confirm New Password", placeholderColor: textColor, textColor: textColor)
                .padding()
                .background(Color(red: 42/255, green: 45/255, blue: 51/255)) // Custom RGB color
                .cornerRadius(10)
                .frame(maxWidth: 300)
            
            HStack {
                Button(action: {
                    // Handle password change logic here
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Submit")
                        .font(.headline)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color(red: 45/255, green: 181/255, blue: 181/255)) // Custom RGB color
                        .cornerRadius(10)
                }
                .padding()
                
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Cancel")
                        .font(.headline)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.red)
                        .cornerRadius(10)
                }
                .padding()
            }
        }
        .padding()
        .background(Color(red: 79/255, green: 85/255, blue: 94/255))
        .cornerRadius(20)
        .shadow(radius: 20)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.opacity(0.5).edgesIgnoringSafeArea(.all))
    }
}

struct ChangePasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ChangePasswordView()
    }
}
