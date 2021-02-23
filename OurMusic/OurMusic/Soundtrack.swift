//
//  Soundtrack.swift
//  OurMusic
//
//  Created by Andranik Khachaturyan on 21.02.2021.
//

import Foundation

struct Soundtrack {
    let title: String
    let artist: String
    
    let urlOnServer: String
    var urlOnDevice: String? = nil
    var url: String {
        urlOnDevice ?? urlOnServer
    }
    
    var image: String {
        title + " - " + artist
    }
    
    var isDownloaded = false
    
}

var musicList = [
    Soundtrack(title: "Warriors", artist: "Imagine Dragons", urlOnServer: "https://www.cloud.com/soundtrack1"),
    Soundtrack(title: "Song 2", artist: "Artist 1", urlOnServer: "https://www.cloud.com/soundtrack2", isDownloaded: true)
]
//.sorted() {
//    $0.artist < $1.artist
//}
//.sorted() {
//    $0.title < $1.title
//}
