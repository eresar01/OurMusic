//
//  Playlist.swift
//  OurMusic
//
//  Created by Yerem Sargsyan on 06.03.21.
//

import Foundation

struct Playlist: Codable {
    
    var id: Int
    var gener: String?
    var artwork_url: String?
    var tracks: [Track]
    var title: String
    
}

