//
//  Extensions.swift
//  OurMusic
//
//  Created by Areg on 2/22/21.
//

import Foundation
import UIKit


extension PlayListVC: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, !text.isEmpty else { return }
        searchBar.resignFirstResponder()
    }
}

extension PlayListVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

extension PlayListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlaylistTableViewCell", for: indexPath) as! PlaylistTableViewCell
        return cell
    }
    
    
}

extension PlayListVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlaylistCollectionViewCell", for: indexPath) as! PlaylistCollectionViewCell
        return cell
    }
    
    
    
}

extension PlayListVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        //return sizeInItem(viewItem: self.playListCollectionView)
        return sizeInItem(viewItem: playListCollectionView)
            
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: conteins, left: conteins, bottom: conteins, right: conteins)
    }
    
    func sizeInItem(viewItem: UICollectionView) -> CGSize {
        let width = viewItem.layer.bounds.width
        //let height = viewItem.layer.bounds.height
        let itemWidth = (width - (conteins * 3)) / 2
        let itemHeight = itemWidth
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
    
    // top on bottom
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return conteins
    }

    
    // right and left
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return conteins
    }
}


extension PlayListVC: UICollectionViewDelegate {
    
}


