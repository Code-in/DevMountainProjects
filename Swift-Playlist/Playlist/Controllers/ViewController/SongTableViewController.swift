//
//  SongTableViewController.swift
//  Playlist
//
//  Created by Pete Parks on 4/15/20.
//  Copyright © 2020 Pete Parks. All rights reserved.
//

import UIKit

private let cellIdentifier = "songCell"

class SongTableViewController: UITableViewController {
    
    // MARK: Outlets
    @IBOutlet weak var songNameTextField: UITextField!
    @IBOutlet weak var artistNameTextField: UITextField!
    
    // MARK: Properties
    var playlist: Playlist?  {
        didSet {
            updateViews()
        }
    }
    
    func updateViews() {
        //guard let playlist = self.playlist, self.isViewLoaded else { return }
        //songNameTextField.text = ""
        //artistNameTextField.text = ""
    }
    

    // MARK: Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: Actions
    
    @IBAction func addSongButtonTapped(_ sender: UIBarButtonItem) {
        guard let playlist = self.playlist, let songName = songNameTextField.text, !songName.isEmpty, let artistName = artistNameTextField.text, !artistName.isEmpty else { return }
        
        SongController.createSongWith(newSongName: songName, newArtistName: artistName, playlist: playlist)
        artistNameTextField.text = ""
        songNameTextField.text = ""
        tableView.reloadData()
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        guard let playlist = self.playlist else { return 0 }
        return playlist.songs.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        // Setup details in cell
        guard let playlist = self.playlist else { return UITableViewCell() }  // Or we could have just returned the cell
        let song = playlist.songs[indexPath.row]
        cell.textLabel?.text = song.songName
        cell.detailTextLabel?.text = song.artistName
        return cell
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            // Delete the row from the data source
            guard let playlist = self.playlist else { return }
            let song = playlist.songs[indexPath.row]
            PlaylistController.sharedInstance.removeSong(songToRemove: song, from: playlist)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }


}
