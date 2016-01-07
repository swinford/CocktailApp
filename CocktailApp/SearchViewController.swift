//
//  SearchViewController.swift
//  CocktailApp
//
//  Created by Zachary Swinford on 12/27/15.
//  Copyright © 2015 Swinford. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var TableView: UITableView!
    @IBOutlet weak var SearchBar: UISearchBar!
    
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

        self.SearchBar.delegate = self
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
        if self.SearchBar.text!.isEmpty {
            
            self.isSearching = false
            
        }else{

            self.isSearching = true
            
            let userSearchInput = self.SearchBar.text!.lowercaseString
            let newString = userSearchInput.stringByReplacingOccurrencesOfString(" ", withString: "%20", options: NSStringCompareOptions.LiteralSearch, range: nil)
            
            let postEndpoint: String = "http://www.thecocktaildb.com/api/json/v1/1/search.php?s=" + newString
            
            guard let url = NSURL(string: postEndpoint) else {
                print("Error: cannot create URL")
                return
            }
            
            let urlRequest = NSURLRequest(URL: url)
            let config = NSURLSessionConfiguration.defaultSessionConfiguration()
            let session = NSURLSession(configuration: config)
            
            let task = session.dataTaskWithRequest(urlRequest, completionHandler: { (data, response, error) in
                guard let responseData = data else {
                    print("Error: did not receive data")
                    return
                }
                guard error == nil else {
                    print("error calling GET on www.thecocktaildb.com")
                    print(error)
                    return
                }
              
                let post: NSDictionary
                do {
                    post = try NSJSONSerialization.JSONObjectWithData(responseData,
                        options: []) as! NSDictionary
                } catch  {
                    print("error trying to convert data to JSON")
                    return
                }

                var count = 1
                if let drinks = post["drinks"] as? [NSDictionary] {
                    for drink in drinks {
                        if let strDrink = drink["strDrink"] as? String {
                            print(String(count) + ". " + strDrink)
                            //self.TableData.append(strDrink)
                            count++
                        }
                        if let strCategory = drink["strCategory"] as? String {
                            print("    Category: " + strCategory)
                        }
                        if let strDrinkThumb = drink["strDrinkThumb"] as? String {
                            print("    Thumbnail Image: " + strDrinkThumb)
                        }
                    }
                }

            })
            task.resume()
            
        }
        
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
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
