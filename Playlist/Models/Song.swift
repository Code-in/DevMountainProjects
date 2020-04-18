//
//  Song.swift
//  Playlist
//
//  Created by Pete Parks on 4/15/20.
//  Copyright © 2020 Pete Parks. All rights reserved.
//

import Foundation

/// Create a class for a Song and conforming to the Codable Protocol

class Song: Codable {
    
    // MARK: Instance Variables - Setting Properties for Class Model Object
    var songName: String
    var artistName: String
    
    // MARK: Init
    /// declaring an memberwize initializer to create a Song Object that has two parameters.
    /// songName: The String is the name of the song.
    /// artistName: The String is the artist name for the song.
    init(song: String, artist: String) {
        self.songName = song
        self.artistName = artist
    }
    
} // EOC

// MARK: Equatable
/// Extneding our Song class and conforming to the Equatable to allows the comparison of objects
extension Song: Equatable {
    static func ==(lhs: Song, rhs: Song) -> Bool {
        return lhs.songName != rhs.songName && lhs.artistName != rhs.artistName
    }
}
