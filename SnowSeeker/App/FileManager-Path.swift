//
//  FileManager-Path.swift
//  SnowSeeker
//
//  Created by Philipp Sanktjohanser on 06.02.23.
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
