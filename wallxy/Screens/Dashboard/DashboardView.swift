//
//  DashboardView.swift
//  wallxy
//
//  Created by Samrat Mukherjee on 03/06/24.
//

import SwiftUI

struct DashboardView: View {
    @ObservedObject var authViewModel: AuthViewModel
    
    @State var tabIndex: Int = 0
    @State var circleXOffset: Double = -132
    @State var tabIcons = ["house", "square.grid.2x2", "heart"]
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                ZStack {
                    if tabIndex == 0 {
                        HomeView(authViewModel: authViewModel)
                    } else if tabIndex == 1 {
                        CategoryView()
                    } else {
                        LikedView()
                    }
                }
                .frame(width: geo.size.width, height: geo.size.height - 60)
                
                HStack {
                    ForEach(0..<3) { index in
                        
                        Spacer()
                            .frame(width: index == 1 ? 40 : 0)
                        
                        VStack {
                            Image(systemName: index == tabIndex ? tabIcons[index] + ".fill" : tabIcons[index])
                                .onTapGesture {
                                    let impactHeavy = UIImpactFeedbackGenerator(style: .heavy)
                                    impactHeavy.impactOccurred()
                                    
                                    tabIndex = index
                                }
                            .font(.system(size: 24))
                            
                            Spacer()
                                .frame(height: tabIndex != index ? 10 : 0)
                            
                            Spacer().frame(height: 5)
                            
                            Circle()
                                .frame(height: tabIndex == index ? 10 : 0)
                                .animation(.easeInOut(duration: 0.2), value: tabIndex)
                        }
                        
                        Spacer()
                            .frame(width: index == 1 ? 40 : 0)
                    }
                }
                .frame(width: geo.size.width, height: 30)
                .padding(.top, 30)
            }
        }
    }
}

#Preview {
    DashboardView(authViewModel: AuthViewModel())
}
