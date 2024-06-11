//
//  RegisterView.swift
//  wallxy
//
//  Created by Samrat Mukherjee on 31/05/24.
//

import SwiftUI
import FirebaseAuth

struct RegisterView: View {
    @Binding var showLoginSheet: Bool
    @Binding var showRegisterSheet: Bool
    @State var emailId: String = ""
    @State var name: String = ""
    @State var password: String = ""
    @State var confirmPassword: String = ""
    @State var showPassword: Bool = false
    
    @ObservedObject var authViewModel: AuthViewModel
    
    var body: some View {
        ZStack {
            Image("register-bg")
                .resizable()
            
            VStack(alignment: .leading) {
                Text("Hi there!\nLet's create an account")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Spacer()
                    .frame(height: 10)
                
                Text("Join us to unlock endless stunning wallpapers for your perfect device background.")
                    .foregroundColor(.white)
                
                Spacer()
                    .frame(height: 20)
                
                //MARK: - Email id Textfield
                ZStack {
                    Spacer()
                        .frame(width: .infinity, height: 55)
                        .background(Color(hex: "707173"))
                        .blendMode(.multiply)
                        .clipShape(.rect(cornerRadius: 10))
                    
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
                
                //MARK: - Name Textfield
                ZStack {
                    Spacer()
                        .frame(width: .infinity, height: 55)
                        .background(Color(hex: "707173"))
                        .blendMode(.multiply)
                        .clipShape(.rect(cornerRadius: 10))
                    
                        TextField(
                            "",
                            text: $name,
                            prompt: Text("Name").foregroundColor(.gray)
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
                        .background(Color(hex: "707173"))
                        .blendMode(.multiply)
                        .clipShape(.rect(cornerRadius: 10))
                    
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
                
                
                //MARK: - Confirm Password Textfield
                ZStack {
                    Spacer()
                        .frame(width: .infinity, height: 55)
                        .background(Color(hex: "707173"))
                        .blendMode(.multiply)
                        .clipShape(.rect(cornerRadius: 10))
                    
                    HStack {
                        if showPassword {
                            TextField("", text: $confirmPassword, prompt: Text("Confirm Password").foregroundColor(.gray))
                                .foregroundColor(.white)
                                .accentColor(.white)
                        } else {
                            SecureField("", text: $confirmPassword, prompt: Text("Confirm Password").foregroundColor(.gray))
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
                
                
                //MARK: - Register Button
                Button {
                    authViewModel.firebaseRegister(email: emailId, password: password, name: name)
                } label: {
                    Text("Register")
                        .fontWeight(.black)
                        .tint(.black)
                }
                .frame(minWidth: 0, maxWidth: .infinity)
                .frame(height: 60)
                .background(.white)
                .clipShape(.rect(cornerRadius: 10))
                
                Spacer()
                    .frame(height: 20)
                
                //MARK: - Register Link
                HStack {
                    Text("Already have an account? ")
                        .foregroundColor(.white)
                    
                    Button {
                        showRegisterSheet.toggle()
                        showLoginSheet.toggle()
                    } label: {
                        Text("Login")
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
    RegisterView(showLoginSheet: .constant(false), showRegisterSheet: .constant(false), authViewModel: AuthViewModel())
}
