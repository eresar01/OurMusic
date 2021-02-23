//
//  SearchListVC.swift
//  OurMusic
//
//  Created by Yerem Sargsyan on 22.02.21.
//

import UIKit

class SearchListVC: UIViewController {

    
    var searchBar = UISearchBar()
    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
        self.navigationItem.titleView = searchBar
        searchBar.delegate = self
        
        // Do any additional setup after loading the view.
    }
    func configure() {
        searchBar.placeholder = "search"
        searchBar.setStyleColor(UIColor.white)
        //searchBar.changeSearchBarColor(color: UIColor.yellow)
        searchBar.searchBarRadius()
        
    }
    
}
extension SearchListVC : UISearchBarDelegate {
    
}
public extension UISearchBar {
    
    public func setStyleColor(_ color: UIColor) {
        //tintColor = color
        guard let textField = (value(forKey: "searchField") as? UITextField) else { return }
        textField.textColor = color
        textField.backgroundColor = .darkGray
        //textField.backgroundColor = color
        var placeholderText = ""
        if self.placeholder != nil{
            placeholderText = self.placeholder!
        }
        textField.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: [NSAttributedString.Key.foregroundColor : color])
        if let glassIconView = textField.leftView as? UIImageView, let img = glassIconView.image {
            let newImg = img.blendedByColor(color)
            glassIconView.image = nil
        }
        if let clearButton = textField.value(forKey: "clearButton") as? UIButton {
            clearButton.setImage(clearButton.imageView?.image?.withRenderingMode(.alwaysTemplate), for: .normal)
            clearButton.tintColor = color
        }
    }
    
    
    func searchBarRadius() {
        
        if let textField = self.subviews.first?.subviews.compactMap({ $0 as? UITextField }).first {
            textField.subviews.first?.isHidden = true
            //textField.textColor = Color.text.primary
            textField.layer.backgroundColor = UIColor.white.cgColor
            textField.layer.cornerRadius = (textField.frame.size.height) / 2
            textField.layer.masksToBounds = true
        }
//        print(self.subviews.count)
//        print(self.frame)
//        self.subviews.forEach { searchBarSubview in
//            print(searchBarSubview.frame)
//            searchBarSubview.subviews.forEach { searchBar in
//                print(searchBar.frame)
//                searchBar.subviews.forEach { search in
//                    print(search.frame)
//                    if search is UITextInputTraits {
//                        do {
//                            let textField = try (search as! UITextField)
//                            print(textField.frame)
//                            textField.layer.cornerRadius = (textField.frame.size.height) / 2
//                            textField.clipsToBounds = true
//                            textField.layer.masksToBounds = true
//                        } catch {
//                            print("searchBarRadius error")
//                        }
//                    }
//                }
//            }
//
//        }
    }
}
extension UIImage {
    
    public func blendedByColor(_ color: UIColor) -> UIImage {
        let scale = UIScreen.main.scale
        if scale > 1 {
            UIGraphicsBeginImageContextWithOptions(size, false, scale)
        } else {
            UIGraphicsBeginImageContext(size)
        }
        color.setFill()
        let bounds = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIRectFill(bounds)
        draw(in: bounds, blendMode: .destinationIn, alpha: 1)
        let blendedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return blendedImage!
    }
}
