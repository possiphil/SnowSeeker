//
//  Favorites.swift
//  SnowSeeker
//
//  Created by Philipp Sanktjohanser on 04.02.23.
//

import Foundation

class Favorites: ObservableObject {
    private var resorts: Set<String> = []
    private let saveKey = "Favorites"
    private let savePath: URL
    
    init() {
        savePath = FileManager.documentsDirectory.appending(path: saveKey)
        load()
    }
    
    func contains(_ resort: Resort) -> Bool {
        resorts.contains(resort.id)
    }
    
    func add(_ resort: Resort) {
        objectWillChange.send()
        resorts.insert(resort.id)
        save()
    }
    
    func remove(_ resort: Resort) {
        objectWillChange.send()
        resorts.remove(resort.id)
        save()
    }
    
    func load() {
        do {
            let data = try Data(contentsOf: savePath)
            resorts = try JSONDecoder().decode(Set<String>.self, from: data)
        } catch {
            resorts = []
        }
    }
    
    func save() {
        do {
            let data = try JSONEncoder().encode(resorts)
            try data.write(to: savePath, options: [.atomic, .completeFileProtection])
        } catch {
            print(error.localizedDescription)
        }
    }
}
