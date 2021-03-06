//
//  Track.swift
//  OurMusic
//
//  Created by Yerem Sargsyan on 06.03.21.
//

import Foundation

struct Track: Codable {
    
    var id: Int
    var title: String
    var stream_url: String
    var artwork_url: String?
    
}

