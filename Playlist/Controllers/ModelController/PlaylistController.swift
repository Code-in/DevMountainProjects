//
//  PlaylistController.swift
//  Playlist
//
//  Created by Pete Parks on 4/15/20.
//  Copyright © 2020 Pete Parks. All rights reserved.
//

import Foundation

class PlaylistController {
    
    //MARK: Singleton
    static let sharedInstance = PlaylistController()
    
    
    // MARK: Source of Truth
    // This allows us to avoid an initilzer and allows us to load without a playlist
    var playlists: [Playlist] = []
    
    
    /*
    init(playlistName: String, songs: [Song] = []) {
        self.playlistName = playlistName
        self.songs = songs
    }
    */
    
    
    // CRUD Methods -  Create Read Update and Delete
    
    
    //Create
    func create(newPlayListName: String) {
        let newPlaylist = Playlist(playlistName: newPlayListName)
        self.playlists.append(newPlaylist)
    }
    
    
    //Delete
    func delete(playListName: Playlist) {
        guard let playlistIndex = self.playlists.firstIndex(of: playListName) else { return }
        self.playlists.remove(at: playlistIndex)
    }
    
    func removeSong(songToRemove: Song, from playlist: Playlist) {
        guard let songIndex = playlist.songs.firstIndex(of: songToRemove) else { return }
        playlist.songs.remove(at: songIndex)
    }
    
    
    //Update
    func updatePlaylistWith(newSong: Song, to playlist: Playlist) {
        playlist.songs.append(newSong)
    }
    
    
    
    //Read - typically used for pulling from API or Database
    
}
