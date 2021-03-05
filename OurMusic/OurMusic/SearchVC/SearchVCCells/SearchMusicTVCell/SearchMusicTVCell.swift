//
//  SearchMusicTVCell.swift
//  OurMusic
//
//  Created by Yerem Sargsyan on 20.02.21.
//

import UIKit

class SearchMusicTVCell: UITableViewCell, SearchCell {

    @IBOutlet weak var musicImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var addButton: UIButton!
    
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        musicImage.image = nil
    }
    
    func setup(data: Any) {
        let track = data as! Track
        self.titleLabel.text = track.title
        guard let url = track.artwork_url else { return }
        self.musicImage.showImage(url: url)
    }
    
    @IBAction func addButton(_ sender: Any) {
        
    }
}
