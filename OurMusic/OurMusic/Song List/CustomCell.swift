//
//  CustomCell.swift
//  OurMusic
//
//  Created by Andranik Khachaturyan on 21.02.2021.
//

import UIKit

class CustomCell: UITableViewCell {
    
    @IBOutlet private weak var title: UILabel!
    @IBOutlet private weak var artist: UILabel!
    @IBOutlet private weak var albumImage: UIImageView!
    @IBOutlet private weak var downloadButton: UIButton!
    @IBOutlet private weak var rowBackground: UIView!
    
    func setup(with soundtrack: Soundtrack) {
        title.text = soundtrack.title
        artist.text = soundtrack.artist
        artist.textColor = .systemGray2
        albumImage.image = UIImage(named: soundtrack.image)
        albumImage.layer.cornerRadius = 5
        rowBackground.layer.cornerRadius = 10
        
        if soundtrack.isDownloaded {
            downloadButton.isHidden = true
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            title.textColor = .purple
        } else {
            title.textColor = .white
        }
        // Configure the view for the selected state
    }

}
