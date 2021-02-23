//
//  SearchMusicTVCell.swift
//  OurMusic
//
//  Created by Yerem Sargsyan on 20.02.21.
//

import UIKit

class SearchMusicTVCell: UITableViewCell, SearchCell {
    
    static var cellId = "SearchMusicTVCell"
    static var nib = UINib(nibName: "SearchMusicTVCell", bundle: nil)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
