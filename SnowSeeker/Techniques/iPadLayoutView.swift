//
//  iPadLayoutView.swift
//  SnowSeeker
//
//  Created by Philipp Sanktjohanser on 01.02.23.
//

import SwiftUI

struct iPadLayoutView: View {
    var body: some View {
        NavigationView {
            NavigationLink {
                Text("New secondary")
            } label: {
                Text("Hello, world!")
            }
            .navigationTitle("Primary")
            
            Text("Secondary")
            
            Text("Tertiary")
        }
    }
}

struct iPadLayoutView_Previews: PreviewProvider {
    static var previews: some View {
        iPadLayoutView()
    }
}
