//
//  PlaylistTableViewController.swift
//  Playlist
//
//  Created by Pete Parks on 4/15/20.
//  Copyright © 2020 Pete Parks. All rights reserved.
//

import UIKit

class PlaylistTableViewController: UITableViewController {
    
    // MARK: Outlets
    @IBOutlet weak var playlistNameTextField: UITextField!
    
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        PlaylistController.sharedInstance.loadFromPersistentStore()
    }
    
    // This is going to update song count in playlists if a song is added
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: Actions
    
    @IBAction func addPlaylistButtonTapped(_ sender: UIBarButtonItem) {
        guard let playlistName = playlistNameTextField.text, !playlistName.isEmpty else { return }
        PlaylistController.sharedInstance.create(newPlayListName: playlistName)
        playlistNameTextField.text = ""
        tableView.reloadData()
    }
    

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return PlaylistController.sharedInstance.playlists.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "playlistCell", for: indexPath)
        let playlist = PlaylistController.sharedInstance.playlists[indexPath.row]
        cell.textLabel?.text = playlist.playlistName
        
        if(playlist.songs.count == 1 ) {
            cell.detailTextLabel?.text = "\(playlist.songs.count) song"
        } else {
            cell.detailTextLabel?.text = "\(playlist.songs.count) songs"
        }
        
        return cell
    }

    // Override to support editing the table view. Also cn be used to delete table rows
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let playlist = PlaylistController.sharedInstance.playlists[indexPath.row]
            PlaylistController.sharedInstance.delete(playListName: playlist)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }    
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    // IIDO
    // Identifier
    if segue.identifier == "toSongVC" {
        // Index - What cell triggered the segue
        // Destination
        guard let indexPath = tableView.indexPathForSelectedRow, let dstVC = segue.destination as? SongTableViewController else { return }
            //(*)navigationItem.backBarButtonItem = UIBarButtonItem(title: "Solar System", style: .plain, target: nil, action: nil)
            // Object to send - What am I trying to send to the next view?
            let playlist = PlaylistController.sharedInstance.playlists[indexPath.row]
            // Object to Recieve - Where is this data sent
            dstVC.playlist = playlist
        }
    }

} // EOC
