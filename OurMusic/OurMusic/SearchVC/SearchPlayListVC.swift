//
//  SearchPlayListVC.swift
//  OurMusic
//
//  Created by Yerem Sargsyan on 26.02.21.
//

import UIKit

class SearchPlayListVC: UIViewController {

    @IBOutlet weak var playListTV: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playListTV.register(SearchMusicTVCell.nib, forCellReuseIdentifier: SearchMusicTVCell.cellId)
        playListTV.dataSource = self
        playListTV.delegate = self
        playListTV.backgroundColor = .black
        self.view.backgroundColor = .black
        self.navigationItem.title = "Lilit Hovhannisyan"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }

}
extension SearchPlayListVC : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchMusicTVCell.cellId, for: indexPath) as! SearchMusicTVCell
        return cell
    }
}

extension SearchPlayListVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}
