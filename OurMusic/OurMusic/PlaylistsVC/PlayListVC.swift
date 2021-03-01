//
//  PlayListVC.swift
//  OurMusic
//
//  Created by Areg on 2/22/21.
//

import UIKit


class PlayListVC: UIViewController {
    
    func test() {
        
    }

    @IBOutlet weak var playListSearchBar: UISearchBar!
    @IBOutlet weak var playListCollectionView: UICollectionView!
    @IBOutlet weak var playListTableView: UITableView!
    let conteins: CGFloat = 12
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playListTableView.delegate = self
        playListTableView.dataSource = self
        let nib = UINib(nibName: "PlaylistTableViewCell", bundle: nil)
        playListTableView.register(nib, forCellReuseIdentifier: "PlaylistTableViewCell")
        playListCollectionView.delegate = self
        playListCollectionView.dataSource = self
        let nibCollection = UINib(nibName: "PlaylistCollectionViewCell", bundle: nil)
        playListCollectionView.register(nibCollection, forCellWithReuseIdentifier: "PlaylistCollectionViewCell")
    }
    
    
    
   
    
}



