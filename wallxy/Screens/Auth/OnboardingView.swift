//
//  SplashView.swift
//  wallxy
//
//  Created by Samrat Mukherjee on 31/05/24.
//

import SwiftUI

struct OnboardingView: View {
    
    @State var showLoginSheet: Bool = false
    @State var showRegisterSheet: Bool = false
    
    @ObservedObject var authViewModel: AuthViewModel
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                Image("splash-bg-3")
                    .resizable()
                    .scaledToFill()
                    .frame(width: geo.size.width, height: geo.size.height / 1.7)
                    .clipShape(.rect(cornerRadii: RectangleCornerRadii(
                        bottomLeading: 40, 
                        bottomTrailing: 40
                    )))
                
                Spacer()
                    .frame(height: 50)
                
                Text("Discover Your")
                    .font(.system(size: 40))
                    .fontWeight(.black)
                    .tint(.gray)
                    .opacity(0.7)
                
                Text("Dream Wallpaper")
                    .font(.system(size: 30))
                    .fontWeight(.bold)
                    .tint(.gray)
                    .opacity(0.7)
                
                Spacer()
                    .frame(height: 30)
                
                Text("Unlock a world of stunning wallpapers! Log in to discover your dream background and transform your device today.")
                    .multilineTextAlignment(.center)
                    .fontWeight(.light)
                    .padding()
                
                //====================
                //MARK: - Auth Buttons
                //====================
                
                ZStack(alignment: .leading) {
                    //MARK: - Register Button
                    HStack {
                        Spacer()
                        Text("Register")
                            .font(.title3)
                            .fontWeight(.heavy)
                        Spacer()
                            .frame(width: 45)
                    }
                    .frame(minWidth: 0, maxWidth: geo.size.width)
                    .frame(height: 70)
                    .background(Color(hex: "EEEEEE"))
                    .tint(.black)
                    .clipShape(.rect(cornerRadii: RectangleCornerRadii(bottomTrailing: 15, topTrailing: 15)))
                    .onTapGesture {
                        // For Haptic Feedback
                        let impactHeavy = UIImpactFeedbackGenerator(style: .heavy)
                        impactHeavy.impactOccurred()
                        
                        showRegisterSheet.toggle()
                    }
                    .sheet(isPresented: $showRegisterSheet, content: {
                        RegisterView(showLoginSheet: $showLoginSheet, showRegisterSheet: $showRegisterSheet, authViewModel: authViewModel)
                    })
                    
                    //MARK: - Login Button
                    HStack {
                        Text("Login")
                            .font(.title3)
                            .fontWeight(.heavy)
                            .foregroundColor(.white)
                    }
                    .frame(width: geo.size.width / 2.2)
                    .frame(height: 70)
                    .background(.black)
                    .tint(.white)
                    .clipShape(.rect(cornerRadii: RectangleCornerRadii(topLeading: 15, bottomLeading: 15)))
                    .onTapGesture {
                        // For Haptic Feedback
                        let impactHeavy = UIImpactFeedbackGenerator(style: .heavy)
                        impactHeavy.impactOccurred()
                        
                        showLoginSheet.toggle()
                    }
                    .sheet(isPresented: $showLoginSheet, content: {
                        LoginView(showRegisterSheet: $showRegisterSheet, showLoginSheet: $showLoginSheet, authViewModel: authViewModel)
                    })
                }
                .padding(.horizontal, 20)
            }
            .ignoresSafeArea()
        }
    }
}

#Preview {
    OnboardingView(authViewModel: AuthViewModel())
}
