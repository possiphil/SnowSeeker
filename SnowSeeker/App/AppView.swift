//
//  AppView.swift
//  SnowSeeker
//
//  Created by Philipp Sanktjohanser on 03.02.23.
//

import SwiftUI

extension View {
    @ViewBuilder func phoneOnlyNavigationView() -> some View {
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.navigationViewStyle(.stack)
        } else {
            self
        }
    }
}

struct AppView: View {
    let resorts: [Resort] = Bundle.main.decode("resorts.json")
    
    @StateObject var favorites = Favorites()
    @State private var searchText = ""
    
    @State private var showFilters = false
    @State private var filter = ResortFilter.standard
    
    var body: some View {
        NavigationView {
            List(filteredResorts) { resort in
                NavigationLink {
                    ResortView(resort: resort)
                } label: {
                    HStack {
                        Image(resort.country)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 25)
                            .clipShape(RoundedRectangle(cornerRadius: 5))
                            .overlay {
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(.black, lineWidth: 1)
                            }
                        
                        VStack(alignment: .leading) {
                            Text(resort.name)
                                .font(.headline)
                            
                            Text("\(resort.runs) runs")
                                .foregroundColor(.secondary)
                        }
                        
                        if favorites.contains(resort) {
                            Spacer()
                            Image(systemName: "heart.fill")
                                .accessibilityLabel("This is a favorite resort")
                                .foregroundColor(.red)
                        }
                    }
                }
            }
            .navigationTitle("Resorts")
            .searchable(text: $searchText, prompt: "Search for a resort")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showFilters.toggle()
                    } label: {
                        Image(systemName: "line.3.horizontal.decrease")
                    }
                }
            }
            .confirmationDialog("Choose Filter", isPresented: $showFilters) {
                Button("Default") { filter = .standard }
                Button("Alphabetical") { filter = .alphabetical }
                Button("Country") { filter = .country }
                Button("Cancel", role: .cancel) { }
            }
            
            WelcomeView()
        }
        .phoneOnlyNavigationView()
        .environmentObject(favorites)
    }
    
    enum ResortFilter {
        case standard
        case alphabetical
        case country
    }
    
    var filteredResorts: [Resort] {
        if searchText.isEmpty {
            switch filter {
            case .standard:     return resorts
            case .alphabetical: return resorts.sorted { $0.name < $1.name }
            case .country:      return resorts.sorted { $0.country < $1.country }
            }
        } else {
            switch filter {
            case .standard:     return resorts.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
            case .alphabetical: return resorts.filter { $0.name.localizedCaseInsensitiveContains(searchText) }.sorted { $0.name < $1.name }
            case .country:      return resorts.filter { $0.name.localizedCaseInsensitiveContains(searchText) }.sorted { $0.country < $1.country }
            }
        }
    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
    }
}
