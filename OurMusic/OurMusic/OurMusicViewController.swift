//
//  ViewController.swift
//  MyMusic
//
//  Created by Afraz Siddiqui on 4/3/20.
//  Copyright © 2020 ASN GROUP LLC. All rights reserved.
//

import UIKit

class OurMusicViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var songs = [Song]()

    @IBOutlet var table: UITableView!


    override func viewDidLoad() {
        super.viewDidLoad()
        configureMySongs()
        table.delegate = self
        table.dataSource = self
    }

    func configureMySongs() {
        songs.append(Song(name: "Sugar Ft Anatu (Cricket & Avaxus Remix) (2020)",
                          albumName: "Sugar",
                          artistName: "Zubi, anatu, Cricket feat. AVAXUS",
                          imageName: "cover1",
                          trackName: "song1"))
        songs.append(Song(name: "simply-falling",
                          albumName: "simply-falling",
                          artistName: "Iyeoka",
                          imageName: "cover2",
                          trackName: "song2"))
        songs.append(Song(name: "On & On feat Daniel Levi",
                          albumName: "On & On feat Daniel Levi",
                          artistName: "Cartoon, Daniel Levi",
                          imageName: "cover3",
                          trackName: "song3"))
        songs.append(Song(name: "Sugar Ft Anatu (Cricket & Avaxus Remix) (2020)",
                          albumName: "Sugar",
                          artistName: "Zubi, anatu, Cricket feat. AVAXUS",
                          imageName: "cover1",
                          trackName: "song1"))
        songs.append(Song(name: "simply-falling",
                          albumName: "simply-falling",
                          artistName: "Iyeoka",
                          imageName: "cover2",
                          trackName: "song2"))
        songs.append(Song(name: "On & On feat Daniel Levi",
                          albumName: "On & On feat Daniel Levi",
                          artistName: "Cartoon, Daniel Levi",
                          imageName: "cover3",
                          trackName: "song3"))
    }

    // Table

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let song = songs[indexPath.row]
        let image = UIImage(named: song.imageName)
        cell.imageView?.layer.cornerRadius = 15
        cell.imageView?.clipsToBounds = true
        // configure
        cell.textLabel?.text = song.name
        cell.detailTextLabel?.text = song.albumName
        cell.accessoryType = .disclosureIndicator
        cell.imageView?.image = image
        cell.textLabel?.font = UIFont(name: "Helvetica-Bold", size: 18)
        cell.detailTextLabel?.font = UIFont(name: "Helvetica", size: 17)

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        // present the player
        let position = indexPath.row
        guard let vc = storyboard?.instantiateViewController(identifier: "player") as? OurMusicPlayerViewController else {
            return
        }
        vc.mySongs = songs
        vc.songsPosition = position
        present(vc, animated: true)
    }


}

struct Song {
    let name: String
    let albumName: String
    let artistName: String
    let imageName: String
    let trackName: String
}
