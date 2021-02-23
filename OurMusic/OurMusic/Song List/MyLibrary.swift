//
//  MyLibrary.swift
//  OurMusic
//
//  Created by Andranik Khachaturyan on 21.02.2021.
//

import UIKit

class MyLibrary: UIViewController {
    
    @IBOutlet weak var list: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        list.dataSource = self
        list.tableFooterView = UIView()
    }
}

extension MyLibrary: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return musicList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! CustomCell
        cell.setup(with: musicList[indexPath.row])
        return cell
    }
    
    
}
