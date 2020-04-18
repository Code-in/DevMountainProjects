//
//  PlaylistController.swift
//  Playlist
//
//  Created by Pete Parks on 4/15/20.
//  Copyright © 2020 Pete Parks. All rights reserved.
//

import Foundation

class PlaylistController {
    
    //MARK: Singleton or SharedInstance
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
    
    
    // MARK: CRUD Methods -  Create Read Update and Delete
    
    //Create
    func create(newPlayListName: String) {
        let newPlaylist = Playlist(playlistName: newPlayListName)
        self.playlists.append(newPlaylist)
        saveToPersistentStore()
    }
    
    //Delete
    func delete(playListName: Playlist) {
        guard let playlistIndex = self.playlists.firstIndex(of: playListName) else { return }
        self.playlists.remove(at: playlistIndex)
        saveToPersistentStore()
    }
    
    func removeSong(songToRemove: Song, from playlist: Playlist) {
        guard let songIndex = playlist.songs.firstIndex(of: songToRemove) else { return }
        playlist.songs.remove(at: songIndex)
        saveToPersistentStore()
    }
    
    //Update
    func updatePlaylistWith(newSong: Song, to playlist: Playlist) {
        playlist.songs.append(newSong)
        saveToPersistentStore()
    }
    
    //Read - typically used for pulling from API or Database
    
    
    
    //MARK: Persistance
    
    func createFileForPersistentStore() -> URL {
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileURL = url[0].appendingPathComponent("Playlist.json")
        return fileURL
    }
    
    func saveToPersistentStore() {
        let je = JSONEncoder()
        
        do {
            let jsonPlaylists = try je.encode(self.playlists)
            try jsonPlaylists.write(to: createFileForPersistentStore())
        } catch let e {
            print("Encoding Error \(e.localizedDescription)")
        }
    }
    
    func loadFromPersistentStore() {
        let jd = JSONDecoder()
        
        do {
            let decodeData = try Data(contentsOf: createFileForPersistentStore())
            self.playlists = try jd.decode([Playlist].self, from: decodeData)
            
        } catch let e {
            print("Decoding Error \(e.localizedDescription)")
        }
    }
    
    
    
}
