//
//  LoginView.swift
//  wallxy
//
//  Created by Samrat Mukherjee on 31/05/24.
//

import SwiftUI
import FirebaseAuth

struct LoginView: View {
    @Binding var showRegisterSheet: Bool
    @Binding var showLoginSheet: Bool
    @State var emailId: String = ""
    @State var password: String = ""
    @State var showPassword: Bool = false
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var authViewModel: AuthViewModel
    
    var body: some View {
        ZStack {
            Image("login-bg")
                .resizable()
            
            VStack(alignment: .leading) {
                Text("Welcome Back!\nLet's login")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Spacer()
                    .frame(height: 10)
                
                Text("Log in to find your dream wallpaper and elevate your device.")
                    .foregroundColor(.white)
                
                Spacer()
                    .frame(height: 20)
                
                //MARK: - Email id Textfield
                ZStack {
                    Spacer()
                        .frame(width: .infinity, height: 55)
                        .background(Color(hex: "EEEEEE"))
                        .clipShape(.rect(cornerRadius: 10))
                        .opacity(0.1)
                    
                        TextField(
                            "",
                            text: $emailId,
                            prompt: Text("Email").foregroundColor(.gray)
                        )
                        .padding()
                        .foregroundColor(.white)
                        .accentColor(.white)
                        .clipShape(.rect(cornerRadius: 10))
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                }
                
                Spacer()
                    .frame(height: 20)
                
                //MARK: - Password Textfield
                ZStack {
                    Spacer()
                        .frame(width: .infinity, height: 55)
                        .background(Color(hex: "EEEEEE"))
                        .clipShape(.rect(cornerRadius: 10))
                        .opacity(0.1)
                    
                    HStack {
                        if showPassword {
                            TextField("", text: $password, prompt: Text("Password").foregroundColor(.gray))
                                .foregroundColor(.white)
                                .accentColor(.white)
                        } else {
                            SecureField("", text: $password, prompt: Text("Password").foregroundColor(.gray))
                                .foregroundColor(.white)
                                .accentColor(.white)
                        }
                        
                        Button {
                            showPassword.toggle()
                        } label: {
                            Image(systemName: showPassword ? "eye.slash" : "eye.fill")
                                .tint(.white)
                        }
                    }
                    .padding()
                    .clipShape(.rect(cornerRadius: 10))
                    .keyboardType(.default)
                    .autocapitalization(.none)
                }
                
                
                Spacer()
                    .frame(height: 20)
                
                
                //MARK: - Login Button
                Button {
                    authViewModel.firebaseLogin(email: emailId, password: password)
                    if authViewModel.isLoggedIn {
                        presentationMode.wrappedValue.dismiss()
                    }
                } label: {
                    Text("Login")
                        .fontWeight(.black)
                        .tint(.black)
                }
                .frame(minWidth: 0, maxWidth: .infinity)
                .frame(height: 60)
                .background(.white)
                .clipShape(.rect(cornerRadius: 10))
                .alert(authViewModel.loginErrorText, isPresented: $authViewModel.showLoginErrorAlert) {
                    Button("Ok", role: .cancel) {
                        authViewModel.loginErrorText = ""
                        authViewModel.disableShowLoginErrorAlert()
                    }
                }
                
                Spacer()
                    .frame(height: 20)
                
                //MARK: - Register Link
                HStack {
                    Text("Don't have an account? ")
                        .foregroundColor(.white)
                    
                    Button {
                        showLoginSheet.toggle()
                        showRegisterSheet.toggle()
                    } label: {
                        Text("Register")
                            .fontWeight(.black)
                            .tint(.white)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .center)
                
                Spacer()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .padding(.vertical, 50)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    LoginView(showRegisterSheet: .constant(false), showLoginSheet: .constant(false), authViewModel: AuthViewModel())
}
