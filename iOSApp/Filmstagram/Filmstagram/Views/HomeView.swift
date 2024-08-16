//
//  HomeView.swift
//  Filmstagram
//
//  Created by Casper on 10/05/2022.
//

import SwiftUI

struct HomeView: View {
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.font: UIFont(name: FontKeys.Nunito.light.rawValue, size: 36) as Any]
    }
    
    var body: some View {
        TabView {
            TimelineView(viewModel: .init())
                .tabItem { Image(systemName: "text.alignleft") }
            ProfileView(viewModel: .init())
                .tabItem { Image(systemName: "person.fill") }
            SettingsView(viewModel: .init())
                .tabItem { Image(systemName: "ellipsis") }
        }
        .accentColor(Color(ColorKeys.oceanBlue.rawValue))
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
