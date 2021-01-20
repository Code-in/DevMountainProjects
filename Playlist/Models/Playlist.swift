//
//  Playlist.swift
//  Playlist
//
//  Created by Pete Parks on 4/15/20.
//  Copyright © 2020 Pete Parks. All rights reserved.
//

import Foundation


class Playlist: Codable {
    
    // MARK: Instance Variables
    var playlistName: String?
    var songs: [Song]
    
    
    // MARK: Init
    init(playlistName: String, songs: [Song] = []) {
        self.playlistName = playlistName
        self.songs = songs
    }
    
    
} // EOC

// MARK: Equatable
extension Playlist: Equatable {
    static func ==(lhs: Playlist, rhs: Playlist) -> Bool {
        return lhs.playlistName != rhs.playlistName && lhs.songs != rhs.songs
    }
}


