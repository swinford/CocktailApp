//
//  SearchViewController.swift
//  CocktailApp
//
//  Created by Zachary Swinford on 12/27/15.
//  Copyright © 2015 Swinford. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate {
    
    @IBOutlet weak var SearchBar: UISearchBar!
    
    // search in progress or not
    var isSearching : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        for subView in self.SearchBar.subviews
        {
            for subsubView in subView.subviews
            {
            
                if let textField = subsubView as? UITextField
                {
                    textField.attributedPlaceholder  = NSAttributedString(string: NSLocalizedString("Search", comment: ""))
                    
                }
            }
        }

        // set search bar delegate
        self.SearchBar.delegate = self
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
        if self.SearchBar.text!.isEmpty {
            
            // set searching false
            self.isSearching = false
            
            
        }else{
            
            // set searghing true
            self.isSearching = true
            
            self.SearchBar.text!.lowercaseString
        }
        
    }
    
    // hide kwyboard when search button clicked
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        self.SearchBar.resignFirstResponder()
    }
    
    // hide keyboard when cancel button clicked
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        self.SearchBar.text = ""
        self.SearchBar.resignFirstResponder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
