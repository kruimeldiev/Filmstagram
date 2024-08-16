//
//  SettingsView.swift
//  Filmstagram
//
//  Created by Casper on 10/05/2022.
//

import SwiftUI

struct SettingsView: View {
    
    @ObservedObject var viewModel: SettingsViewModel
    
    var body: some View {
        List {
            Button {
                viewModel.logoutUser()
            } label: {
                Text("Logout")
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(viewModel: .init())
    }
}
