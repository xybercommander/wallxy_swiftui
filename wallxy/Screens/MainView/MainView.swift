//
//  MainView.swift
//  wallxy
//
//  Created by Samrat Mukherjee on 04/06/24.
//

import SwiftUI

struct MainView: View {
    
    @StateObject var authViewModel = AuthViewModel()
    
    var body: some View {
        if authViewModel.isLoggedIn {
            DashboardView(authViewModel: authViewModel)
        } else {
            OnboardingView(authViewModel: authViewModel)
        }
    }
}

#Preview {
    MainView()
}
