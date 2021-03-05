//
//  CachedTVCell.swift
//  OurMusic
//
//  Created by Yerem Sargsyan on 26.02.21.
//

import UIKit

class CachedTVCell: UITableViewCell, SearchCell  {
    
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var deleteImage: UIImageView!
    @IBOutlet weak var borderView: UIView!
    
    static var cellId = "CachedTVCell"
    static var nib = UINib(nibName: "CachedTVCell", bundle: nil)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupTintColor(color: .darkGray)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setup(data: Any) {
        let text = data as! String
        self.titleLabel.text = text
    }
    
    func setupTintColor(color: UIColor) {
        iconImage.tintColor = color
        titleLabel.textColor = color
        deleteImage.tintColor = color
        borderView.backgroundColor = color
    }
    
}
