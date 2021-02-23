//
//  SearchVC.swift
//  OurMusic
//
//  Created by Yerem Sargsyan on 20.02.21.
//

import UIKit

protocol SearchCell: UITableViewCell {
    static var cellId : String { get }
    static var nib : UINib { get }
}

class SearchVC: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchTableView: UITableView!
    private var isHavePlayList = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTableView.register(SearchMusicTVCell.nib, forCellReuseIdentifier: SearchMusicTVCell.cellId)
        searchTableView.register(SearchPlayListsTVCell.nib, forCellReuseIdentifier: SearchPlayListsTVCell.cellId)
        searchTableView.dataSource = self
        searchTableView.delegate = self
        searchBar.delegate = self
        view.backgroundColor = .black
        searchTableView.backgroundColor = .black
    }
    
}
// MARK: UITableViewDataSource
extension SearchVC : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return isHavePlayList ? 2 : 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isHavePlayList {
            switch section {
            case 0:
                return 1
            case 1:
                return 20
            default:
                return 0
            }
        } else {
            return 20
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isHavePlayList {
            switch indexPath.section {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: SearchPlayListsTVCell.cellId, for: indexPath) as! SearchPlayListsTVCell
                return cell
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: SearchMusicTVCell.cellId, for: indexPath) as! SearchMusicTVCell
                return cell
            default:
                return UITableViewCell()
            }
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: SearchMusicTVCell.cellId, for: indexPath) as! SearchMusicTVCell
            return cell
        }
    }
}
// MARK: UITableViewDelegate
extension SearchVC : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if isHavePlayList {
            switch indexPath.section {
            case 0:
                return 200
            case 1:
                return 80
            default:
                return 0
            }
        }else {
            return 80
        }
        
    }
}
extension SearchVC : UISearchBarDelegate {
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        print("searchBarShouldBeginEditing")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nextVC = storyboard.instantiateViewController(withIdentifier: "SearchListVC") as! SearchListVC
        //nextVC.newsData = self.newsData[indexPath.row]
        self.navigationController?.pushViewController(nextVC, animated: false)
        return false
    }
    
//    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
//        print("searchBarTextDidBeginEditing")
//    }
//
//    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
//        print("searchBarShouldEndEditing")
//        return true
//    }
//
//    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
//        print("searchBarTextDidEndEditing")
//
//    }
}
