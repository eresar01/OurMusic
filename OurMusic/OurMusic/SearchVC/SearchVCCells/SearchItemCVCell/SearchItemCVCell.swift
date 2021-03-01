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

}
