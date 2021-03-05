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
    
    func setup(data: Any)
}

class SearchVC: UIViewController {
    
    @IBOutlet weak var searchTableView: UITableView!
    
    private let controller = SearchController()
    
    var searchController: UISearchController!
    
    var searchText = ""
    var state: SearchState = .defoult
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTableView.register(SearchPlayListsTVCell.nib, forCellReuseIdentifier: SearchPlayListsTVCell.cellId)
        searchTableView.register(SearchMusicTVCell.nib, forCellReuseIdentifier: SearchMusicTVCell.cellId)
        searchTableView.register(CachedTVCell.nib, forCellReuseIdentifier: CachedTVCell.cellId)
        searchTableView.dataSource = self
        searchTableView.delegate = self
        searchTableView.backgroundColor = .black
        
        self.view.backgroundColor = .black
        self.navigationItem.title = "Search"
        searchControllerSetup()
    }
    
// MARK: Dzevapoxel
    func searchControllerSetup() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.delegate = self
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        let scb = searchController.searchBar
        scb.tintColor = UIColor.white
        scb.barTintColor = UIColor.white
        
        
        if let textfield = scb.value(forKey: "searchField") as? UITextField {
            textfield.textColor = UIColor.blue
            if let backgroundview = textfield.subviews.first {
                print("backgroundview")
                // Background color
                backgroundview.backgroundColor = UIColor.white
                
                // Rounded corner
                backgroundview.layer.cornerRadius = backgroundview.frame.width / 2;
                backgroundview.clipsToBounds = true;
                
            }
        }
        
        if let navigationbar = self.navigationController?.navigationBar {
            navigationbar.barTintColor = UIColor.black
        }
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
}
// MARK: UITableViewDataSource
extension SearchVC : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        switch state {
            case .defoult:
                return 2
            case .isActiv:
                return 1
            case .isHavePlayList:
                return 1
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch state {
            case .defoult:
                if section == 0 && controller.playlistCount != 0 {
                    return 1
                }
                return controller.trackCount
            case .isActiv:
                return controller.lookCount
            case .isHavePlayList:
                return controller.trackCount
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: SearchCell
        switch state {
            case .defoult:
                if indexPath.section == 0 {
                    let cell = tableView.dequeueReusableCell(withIdentifier: SearchPlayListsTVCell.cellId, for: indexPath) as! SearchPlayListsTVCell
                    cell.delegate = self
                    cell.setup(data: controller.playlists)
                    return cell
                }
                cell = tableView.dequeueReusableCell(withIdentifier: SearchMusicTVCell.cellId, for: indexPath) as! SearchMusicTVCell
                let track = controller.track(at: indexPath.row)
                cell.setup(data: track)
            case .isActiv:
                cell = tableView.dequeueReusableCell(withIdentifier: CachedTVCell.cellId, for: indexPath) as! CachedTVCell
                let cacheData = controller.look(at: indexPath.row)
                cell.setup(data: cacheData)
            case .isHavePlayList:
                
                cell = tableView.dequeueReusableCell(withIdentifier: SearchMusicTVCell.cellId, for: indexPath) as! SearchMusicTVCell
                let track = controller.track(at: indexPath.row)
                cell.setup(data: track)
            }
            return cell
        }
    }
// MARK: UITableViewDelegate
extension SearchVC : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch state {
            case .defoult:
                controller.playingMusic(controller.track(at: indexPath.row))
            case .isActiv:
                let searchText = controller.look(at: indexPath.row)
                DispatchQueue.main.async { [self] in
                    controller.getData(searchText: searchText) { state in
                        
                        self.state = state
                        searchController.isActive = false
                        searchTableView.reloadData()
                    }
                }
                //DispatchGroup
            case .isHavePlayList:
                controller.playingMusic(controller.track(at: indexPath.row))
        }
       
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch state {
            case .defoult:
                if indexPath.section == 0 {
                    return 200
                }
                return 80
            case .isActiv:
                return 60
            case .isHavePlayList:
                return 80
            }
    }
}
// MARK: UISearchControllerDelegate
extension SearchVC: UISearchControllerDelegate ,UISearchResultsUpdating, UISearchBarDelegate  {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        DispatchQueue.main.async { [self] in
            controller.getData(searchText: searchText) { state in
                self.state = state
                searchController.isActive = false
                searchTableView.reloadData()
            }
        }
        controller.looks.append(self.searchText)
        dismissKeyboard()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if let text = searchController.searchBar.text {
            self.searchText = text.replacingOccurrences(of: " ", with: "_")
        }
    }
    
    func willPresentSearchController(_ searchController: UISearchController) {
        self.state = .isActiv
        animateion(for: self.searchTableView)
    }
    
    func willDismissSearchController(_ searchController: UISearchController) {
        self.state = controller.state
        animateion(for: self.searchTableView)
    }
    
    func animateion(for tableView: UITableView) {
        tableView.alpha = 0
        UIView.animate(withDuration: 0.3, animations: {
            tableView.alpha = 1
            tableView.reloadData()
        })
    }
}

extension SearchVC : SearchPlayListsTVCellDelegate {
    func didSelectItem(at indexPath: IndexPath) {
        print(indexPath.row)
        nextVC(index: indexPath.row)
    }
    
    func nextVC(index: Int) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nextVC = storyboard.instantiateViewController(withIdentifier: "SearchPlayListVC") as! SearchPlayListVC
        nextVC.musiclist = controller.playlist(at: index).tracks//playlistData[index].tracks
        nextVC.titleList = controller.playlist(at: index).title
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}

