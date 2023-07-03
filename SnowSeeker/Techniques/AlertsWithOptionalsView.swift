//
//  AlertsWithOptionalsView.swift
//  SnowSeeker
//
//  Created by Philipp Sanktjohanser on 01.02.23.
//

import SwiftUI

struct User: Identifiable {
    var id = "Taylor Swift"
}

struct AlertsWithOptionalsView: View {
    @State private var selectedUser: User? = nil
    @State private var isShowingUser = false
    @State private var isShowingAlert = false
    
    var body: some View {
        VStack(spacing: 24) {
            Text("Hello, World!")
                .onTapGesture {
                    selectedUser = User()
                }
            
            Text("Show alert")
                .onTapGesture {
                    selectedUser = User()
                    isShowingUser = true
                }
            
            Text("Empty alert")
                .onTapGesture {
                    isShowingAlert = true
                }
        }
        .sheet(item: $selectedUser) { user in
            Text(user.id)
        }
        .alert("Welcome", isPresented: $isShowingUser, presenting: selectedUser) { user in
            Button(user.id) { }
        }
        .alert("Empty Alert", isPresented: $isShowingUser) { }
    }
}

struct AlertsWithOptionalsView_Previews: PreviewProvider {
    static var previews: some View {
        AlertsWithOptionalsView()
    }
}
