//
//  SongController.swift
//  Playlist
//
//  Created by Pete Parks on 4/15/20.
//  Copyright © 2020 Pete Parks. All rights reserved.
//

import Foundation


class SongController {
    
    static func createSongWith(newSongName: String, newArtistName: String, playlist: Playlist) {
        let newSong = Song(song: newSongName, artist: newArtistName)
        PlaylistController.sharedInstance.updatePlaylistWith(newSong: newSong, to: playlist )
    }
    
    
} // EOC
