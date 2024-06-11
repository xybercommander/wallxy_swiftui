//
//  HomeView.swift
//  wallxy
//
//  Created by Samrat Mukherjee on 10/06/24.
//

import SwiftUI
import StaggeredList
import PinterestLikeGrid

struct HomeView: View {
    @ObservedObject var authViewModel: AuthViewModel
    @StateObject var homeViewModel = HomeViewModel()
    @State var images = ["login-bg", "splash-bg-2", "splash-bg", "splash-bg-1", "register-bg", "login-bg"]
    
    var body: some View {
        ScrollView {
            //MARK: - Appbar
            HStack {
                Button {
                    debugPrint("Search")
                } label: {
                    ZStack {
                        Circle()
                            .strokeBorder(.black)
                            .frame(width: 40, height: 40)
                        
                        Image(systemName: "magnifyingglass")
                            .accentColor(.black)
                    }
                }
                .padding(.trailing, 5)
                
                Button {
                    debugPrint("Search")
                } label: {
                    Image("user")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                }
            }
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
            .padding(.horizontal, 16)
            
            
            //MARK: - Header
            VStack(alignment: .leading) {
                Text("Hi \(authViewModel.name)!")
                    .font(.largeTitle)
                .fontWeight(.black)
                
                Text("Try out a new wallpaper today!")
                    .foregroundColor(.gray)
                    .font(.callout)
                    .fontWeight(.semibold)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 16)
            
            
            Spacer().frame(height: 40)
            
            
            //MARK: - Popular Categories
            HStack {
                Text("Popular Categories")
                    .font(.title3)
                .fontWeight(.bold)
                
                Spacer()
                
                Button {
                    
                } label: {
                     Text("View all")
                        .font(.callout)
                        .fontWeight(.bold)
                        .foregroundColor(.gray)
                }
            }
            .padding(.horizontal, 16)
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack {
                    ForEach(0..<21, id: \.self) { index in
                        Image("splash-bg")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 60, height: 60)
                            .clipShape(Circle())
                            .padding(.leading, index == 0 ? 16 : 0)
                            .padding(.trailing, index == 20 ? 16 : 0)
                    }
                }
            }
            
            Spacer().frame(height: 60)
            
            //MARK: - Popular Categories
            HStack {
                Text("Trending")
                    .font(.title3)
                .fontWeight(.bold)
                
                Spacer()
                
                Button {
                    
                } label: {
                     Text("View all")
                        .font(.callout)
                        .fontWeight(.bold)
                        .foregroundColor(.gray)
                }
            }
            .padding(.horizontal, 16)
            
            if homeViewModel.initLoading {
                ProgressView()
            } else {
                PinterestLikeGrid($homeViewModel.photoList, columns: 2, rowSpacing: 6) { item, index in
                    AsyncImage(url: URL(string: item)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .clipShape(.rect(cornerRadius: 10))
                    } placeholder: {
                        ProgressView()
                    }
                }
                .padding()
            }
            
        }
        .onAppear() {
            homeViewModel.fetchHomeImages()
        }
    }
}

#Preview {
    HomeView(authViewModel: AuthViewModel())
}
