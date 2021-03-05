//
//  SearchPlayListsTVCell.swift
//  OurMusic
//
//  Created by Yerem Sargsyan on 20.02.21.
//

import UIKit

protocol SearchPlayListsTVCellDelegate {
    func didSelectItem(at indexPath: IndexPath)
}

class SearchPlayListsTVCell: UITableViewCell, SearchCell {
    
    static var cellId = "SearchPlayListsTVCell"
    static var nib = UINib(nibName: "SearchPlayListsTVCell", bundle: nil)
    
    @IBOutlet weak var playListCV: UICollectionView!
    
    var playlistData : [Playlist] = [] {
        didSet {
            playListCV.reloadData()
        }
    }
    
    var delegate: SearchPlayListsTVCellDelegate?
    private let conteins : CGFloat = 12
    
    override func awakeFromNib() {
        super.awakeFromNib()
        playListCV.register(SearchItemCVCell.nib, forCellWithReuseIdentifier: SearchItemCVCell.cellId)
        playListCV.delegate = self
        playListCV.dataSource = self
        playListCV.backgroundColor = .black
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setup(data: Any) {
        guard let data = data as? [Playlist] else { return }
        self.playlistData = data
    }
}

//MARK: UICollectionViewDataSource
extension SearchPlayListsTVCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return playlistData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchItemCVCell.cellId, for: indexPath) as! SearchItemCVCell
        let list = playlistData[indexPath.row]
        cell.setup(playlist: list)
        return cell
    }
}

//MARK: UICollectionViewDelegate
extension SearchPlayListsTVCell: UICollectionViewDelegateFlowLayout {
    
    func sizeInItem(viewItem:UICollectionView) -> CGSize {
        let widht = viewItem.layer.bounds.width
        let height = viewItem.layer.bounds.height
        let itemWidht = (widht - (conteins * 3)) / 2.8
        let itemHeight = height - (conteins * 2)
        let size = CGSize(width: itemWidht, height: itemHeight)
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.sizeInItem(viewItem: playListCV)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: conteins, left: conteins, bottom: conteins, right: conteins)
    }
    
        // top or bottom
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return conteins
    }

    // right or left
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return conteins
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectItem(at: indexPath)
    }
}
