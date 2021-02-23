//
//  topBarController.swift
//  OurMusic
//
//  Created by Srbuhi Hakobyan on 21.02.21.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let topVC = storyboard.instantiateViewController(identifier: "TopPageVC")
        let navTop = generateNavController(vc: topVC, title: "Top")
        let navMyLibrary  = generateNavController(vc: ViewController(), title: "My Library")
        let navPlaylist = generateNavController(vc: ViewController(), title: "Play list")
        let navSearch = generateNavController(vc: ViewController(), title: "Search")
        
        
        UINavigationBar.appearance().prefersLargeTitles = true
        viewControllers = [navTop, navMyLibrary, navPlaylist, navSearch]
        

    }
    
    fileprivate func generateNavController(vc: UIViewController, title: String) -> UINavigationController{
        let navController = UINavigationController(rootViewController: vc)
        navController.title = title
        return navController
    }
}
