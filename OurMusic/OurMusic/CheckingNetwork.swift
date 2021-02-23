//
//  CheckingNetwork.swift
//  OurMusic
//
//  Created by Andranik Khachaturyan on 21.02.2021.
//

import Network

let monitor = NWPathMonitor()
let queue = DispatchQueue(label: "Monitor")

func checkNetwork() {
    
    monitor.pathUpdateHandler = { path in
        if path.status == .satisfied {
            print("Connected")
        } else {
            print("Disconnected")
        }
    }
    
    monitor.start(queue: queue)
}
