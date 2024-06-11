//
//  ContentView.swift
//  wallxy
//
//  Created by Samrat Mukherjee on 31/05/24.
//

import SwiftUI
import FirebaseCore
import FirebaseAppCheck

struct ContentView: View {
    
    init() {
        let providerFactory = AppCheckDebugProviderFactory()
        AppCheck.setAppCheckProviderFactory(providerFactory)
        
        FirebaseApp.configure()
    }
    
    var body: some View {
        MainView()
            .preferredColorScheme(.light)
    }
}

#Preview {
    ContentView()
}
