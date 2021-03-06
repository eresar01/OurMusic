//
//  SearchController.swift
//  OurMusic
//
//  Created by Yerem Sargsyan on 06.03.21.
//

import AVFoundation
import Foundation

enum SearchState : Int {
    case defoult, isActiv, isHavePlayList
    var state: Int {
        switch self {
        case .defoult:
            return 0
        case .isActiv:
            return 1
        case .isHavePlayList:
            return 2
        }
    }
}

protocol MusicDataDelegate {
    func getData(_ tracks: [Track])
}

protocol PlaylistDataDelegate {
    func getData(_ playlists: [Playlist])
}

class SearchController {
    
    var tracks = [Track]()
    var playlists = [Playlist]()
    var looks = [String]()
    
    let dataMeneger = DataMeneger()
    
    var state: SearchState = .defoult
    
    var audioPlayer = AVPlayer()
    
    init() {
//        DataMeneger.remoteDatasource.musicDataDelegate = self
//        DataMeneger.remoteDatasource.playlistDataDelegate = self
    }
    
    func getData(searchText: String, callback: @escaping (_ state: SearchState) -> Void) {
        dataMeneger.call(searchText: searchText) {
            print("playlistCount",self.playlistCount)
            print("trackCount",self.trackCount)
            if !self.playlists.isEmpty && !self.tracks.isEmpty {
                self.state = .defoult
                return callback(.defoult)
            } else if self.playlists.isEmpty {
                self.state = .isHavePlayList
                
            } else {
                // TODO:
            }
            callback(self.state)
        }
    }
    
    var trackCount: Int {
        return tracks.count
    }
    
    var playlistCount: Int {
        return playlists.count
    }
    
    var lookCount: Int {
        return looks.count
    }
    
    func track(at index: Int) -> Track {
        return tracks[index]
    }
    
    func playlist(at index: Int) -> Playlist {
        return playlists[index]
    }
    
    func look(at index: Int) -> String {
        return looks[index]
    }
    
    func playingMusic(_ track: Track) {
        do {
            let url = track.stream_url + "?client_id=5f61421beef03933a192f6ea1266e293"
            let fileURL = URL(string:url)
            self.audioPlayer = try AVPlayer(url: fileURL!)
            audioPlayer.volume = 1.0
            audioPlayer.play()
        } catch {
            print("Error getting the audio file")
        }
    }
}

extension SearchController: MusicDataDelegate {
    
    func getData(_ tracks: [Track]) {
        self.tracks = tracks
    }
    
}

extension SearchController: PlaylistDataDelegate {
    
    func getData(_ playlists: [Playlist]) {
        self.playlists = playlists
    }
}

class DataMeneger {
    
    //static var remoteDatasource = RemoteDatasource()
    
    func call(searchText: String, callback: @escaping () -> Void) {
       //DataMeneger.remoteDatasource.call(searchText: searchText, callback: callback)
    }
}

