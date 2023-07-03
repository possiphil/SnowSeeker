//
//  GroupView.swift
//  SnowSeeker
//
//  Created by Philipp Sanktjohanser on 01.02.23.
//

import SwiftUI

struct UserView: View {
    var body: some View {
        Group {
            Text("Name: Paul")
            Text("County: England")
            Text("Pets: Luna and Arya")
        }
        .font(.title)
    }
}

struct GroupView: View {
    @Environment(\.horizontalSizeClass) var sizeClass
    
    var body: some View {
        if sizeClass == .compact {
            VStack(content: UserView.init)
        } else {
            HStack(content: UserView.init)
        }
    }
}

struct GroupView_Previews: PreviewProvider {
    static var previews: some View {
        GroupView()
    }
}
