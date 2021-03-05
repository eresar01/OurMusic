//
//  SearchItemCVCell.swift
//  OurMusic
//
//  Created by Yerem Sargsyan on 20.02.21.
//

import UIKit

class SearchItemCVCell: UICollectionViewCell {
    
    @IBOutlet weak var playListImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    static let cellId = "SearchItemCVCell"
    static let nib = UINib(nibName: "SearchItemCVCell", bundle: nil)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //self.contentView.backgroundColor = .black
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        playListImage.image = nil
    }
    
    func setup(playlist : Playlist) {
        self.titleLabel.text = playlist.title
        if let url = playlist.artwork_url {
            self.playListImage.showImage(url: url)
        } else if !playlist.tracks.isEmpty  {
            guard let url = playlist.tracks[0].artwork_url else { return }
           // let url = playlist.tracks[0].artwork_url
            self.playListImage.showImage(url: url)
        }
       
    }
    
}
