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
    
    func setup()
}

enum SearchState : Int {
    case defoult, isActiv, isHavePlayList
    var state : Int {
        switch self {
        case .defoult:
            return 0
        case .isActiv:
            return 1
        case .isHavePlayList:
            return 2
        }
    }
}

class SearchVC: UIViewController {
    
    @IBOutlet weak var searchTableView: UITableView!
    
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
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        self.navigationController?.navigationBar.prefersLargeTitles = false
//    }
//    
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        self.navigationController?.navigationBar.prefersLargeTitles = true
//    }
    
// MARK: Dzevapoxel
    func searchControllerSetup() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.delegate = self
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
            navigationbar.barTintColor = UIColor.blue
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
                if section == 0 {
                    return 1
                }
                return 20
            case .isActiv:
                return 20
            case .isHavePlayList:
                return 20
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: SearchCell
        switch state {
            case .defoult:
                if indexPath.section == 0 {
                    let cell = tableView.dequeueReusableCell(withIdentifier: SearchPlayListsTVCell.cellId, for: indexPath) as! SearchPlayListsTVCell
                    cell.delegate = self
                    return cell
                }
                cell = tableView.dequeueReusableCell(withIdentifier: SearchMusicTVCell.cellId, for: indexPath) as! SearchMusicTVCell
            
            case .isActiv:
                cell = tableView.dequeueReusableCell(withIdentifier: CachedTVCell.cellId, for: indexPath) as! CachedTVCell
            
            case .isHavePlayList:
                cell = tableView.dequeueReusableCell(withIdentifier: SearchMusicTVCell.cellId, for: indexPath) as! SearchMusicTVCell
            }
            return cell
        }
    }
// MARK: UITableViewDelegate
extension SearchVC : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
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
extension SearchVC: UISearchControllerDelegate ,UISearchResultsUpdating  {
    
    func updateSearchResults(for searchController: UISearchController) {
        if let text = searchController.searchBar.text {
            print(text)
        }
    }
    
    func willPresentSearchController(_ searchController: UISearchController) {
        self.state = .isActiv
        animateion(for: self.searchTableView)
    }
    
    func willDismissSearchController(_ searchController: UISearchController) {
        self.state = .defoult
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
        nextVC()
    }
    
    func nextVC() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nextVC = storyboard.instantiateViewController(withIdentifier: "SearchPlayListVC") as! SearchPlayListVC
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}
