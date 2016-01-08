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
    
    var valueToPass: Drinks!
    var isSearching: Bool = false
    
    class Drinks {
        var idDrink: Int = 0
        var strDrink: String = ""
        var strCategory: String = ""
        
        var strAlcoholic: String = ""
        var strGlass: String = ""
        var strInstructions: String = ""
        
        var strDrinkThumb: String = ""
        
        var strIngredient1: String = ""
        var strIngredient2: String = ""
        var strIngredient3: String = ""
        var strIngredient4: String = ""
        var strIngredient5: String = ""
        var strIngredient6: String = ""
        var strIngredient7: String = ""
        var strIngredient8: String = ""
        var strIngredient9: String = ""
        var strIngredient10: String = ""
        var strIngredient11: String = ""
        var strIngredient12: String = ""
        var strIngredient13: String = ""
        var strIngredient14: String = ""
        var strIngredient15: String = ""

        var strMeasure1: String = ""
        var strMeasure2: String = ""
        var strMeasure3: String = ""
        var strMeasure4: String = ""
        var strMeasure5: String = ""
        var strMeasure6: String = ""
        var strMeasure7: String = ""
        var strMeasure8: String = ""
        var strMeasure9: String = ""
        var strMeasure10: String = ""
        var strMeasure11: String = ""
        var strMeasure12: String = ""
        var strMeasure13: String = ""
        var strMeasure14: String = ""
        var strMeasure15: String = ""
    }
    var TableData:Array< Drinks > = Array < Drinks >()
    
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
        self.TableView.delegate = self
        self.TableView.dataSource = self
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
                    self.TableData.removeAll()
                    for drink in drinks {
                        let adrink = Drinks()
                        
                        if let strDrink = drink["strDrink"] as? String {
                            print(String(count) + ". " + strDrink)
                            adrink.strDrink = strDrink
                            count++
                        }
                        if let strDrinkThumb = drink["strDrinkThumb"] as? String {
                            //print("    Thumbnail Image: " + strDrinkThumb)
                            adrink.strDrinkThumb = strDrinkThumb
                        }
                        if let strGlass = drink["strGlass"] as? String {
                            adrink.strGlass = strGlass
                        }
                        if let strCategory = drink["strCategory"] as? String {
                            adrink.strCategory = strCategory
                        }
                        if let strAlcoholic = drink["strAlcoholic"] as? String {
                            adrink.strAlcoholic = strAlcoholic
                        }
                        if let strInstructions = drink["strInstructions"] as? String {
                            adrink.strInstructions = strInstructions
                        }
                        if let strIngredient1 = drink["strIngredient1"] as? String {
                            adrink.strIngredient1 = strIngredient1
                        }
                        if let strIngredient2 = drink["strIngredient2"] as? String {
                            adrink.strIngredient2 = strIngredient2
                        }
                        if let strIngredient3 = drink["strIngredient3"] as? String {
                            adrink.strIngredient3 = strIngredient3
                        }
                        if let strIngredient4 = drink["strIngredient4"] as? String {
                            adrink.strIngredient4 = strIngredient4
                        }
                        if let strIngredient5 = drink["strIngredient5"] as? String {
                            adrink.strIngredient5 = strIngredient5
                        }
                        if let strIngredient6 = drink["strIngredient6"] as? String {
                            adrink.strIngredient6 = strIngredient6
                        }
                        if let strIngredient7 = drink["strIngredient7"] as? String {
                            adrink.strIngredient7 = strIngredient7
                        }
                        if let strIngredient8 = drink["strIngredient8"] as? String {
                            adrink.strIngredient8 = strIngredient8
                        }
                        if let strIngredient9 = drink["strIngredient9"] as? String {
                            adrink.strIngredient9 = strIngredient9
                        }
                        if let strIngredient10 = drink["strIngredient10"] as? String {
                            adrink.strIngredient10 = strIngredient10
                        }
                        if let strIngredient11 = drink["strIngredient11"] as? String {
                            adrink.strIngredient11 = strIngredient11
                        }
                        if let strIngredient12 = drink["strIngredient12"] as? String {
                            adrink.strIngredient12 = strIngredient12
                        }
                        if let strIngredient13 = drink["strIngredient13"] as? String {
                            adrink.strIngredient13 = strIngredient13
                        }
                        if let strIngredient14 = drink["strIngredient14"] as? String {
                            adrink.strIngredient14 = strIngredient14
                        }
                        if let strIngredient15 = drink["strIngredient15"] as? String {
                            adrink.strIngredient15 = strIngredient15
                        }
                        if let strMeasure1 = drink["strMeasure1"] as? String {
                            adrink.strMeasure1 = strMeasure1
                        }
                        if let strMeasure2 = drink["strMeasure2"] as? String {
                            adrink.strMeasure2 = strMeasure2
                        }
                        if let strMeasure3 = drink["strMeasure3"] as? String {
                            adrink.strMeasure3 = strMeasure3
                        }
                        if let strMeasure4 = drink["strMeasure4"] as? String {
                            adrink.strMeasure4 = strMeasure4
                        }
                        if let strMeasure5 = drink["strMeasure5"] as? String {
                            adrink.strMeasure5 = strMeasure5
                        }
                        if let strMeasure6 = drink["strMeasure6"] as? String {
                            adrink.strMeasure6 = strMeasure6
                        }
                        if let strMeasure7 = drink["strMeasure7"] as? String {
                            adrink.strMeasure7 = strMeasure7
                        }
                        if let strMeasure8 = drink["strMeasure8"] as? String {
                            adrink.strMeasure8 = strMeasure8
                        }
                        if let strMeasure9 = drink["strMeasure9"] as? String {
                            adrink.strMeasure9 = strMeasure9
                        }
                        if let strMeasure10 = drink["strMeasure10"] as? String {
                            adrink.strMeasure10 = strMeasure10
                        }
                        if let strMeasure11 = drink["strMeasure11"] as? String {
                            adrink.strMeasure11 = strMeasure11
                        }
                        if let strMeasure12 = drink["strMeasure12"] as? String {
                            adrink.strMeasure12 = strMeasure12
                        }
                        if let strMeasure13 = drink["strMeasure13"] as? String {
                            adrink.strMeasure13 = strMeasure13
                        }
                        if let strMeasure14 = drink["strMeasure14"] as? String {
                            adrink.strMeasure14 = strMeasure14
                        }
                        if let strMeasure15 = drink["strMeasure15"] as? String {
                            adrink.strMeasure15 = strMeasure15
                        }
 
                        self.TableData.append(adrink)
                        self.TableView.reloadData()
                    }
                }
            })
            task.resume()
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TableData.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) 
        //title = TableData[indexPath.row].strDrink
        
        cell.textLabel?.text = TableData[indexPath.row].strDrink;
        cell.detailTextLabel?.text = TableData[indexPath.row].strCategory
        
        let imageString = TableData[indexPath.row].strDrinkThumb
        
        if (imageString == ""){
            let noDrinkImage : UIImage = UIImage(named: "noimage.jpg")!
            cell.imageView!.image = noDrinkImage
        }else{
            let drinkImage =  UIImage(data: NSData(contentsOfURL: NSURL(string:TableData[indexPath.row].strDrinkThumb)!)!)
            cell.imageView!.image = drinkImage
        }
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        print(TableData[indexPath.row].strDrink)
        valueToPass = TableData[indexPath.row]
        self.performSegueWithIdentifier("DrinkSegue", sender: TableData[indexPath.row])
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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "DrinkSegue") {
            // initialize new view controller and cast it as your view controller
            let drinkViewController = segue.destinationViewController as! DrinkViewController
            // your new view controller should have property that will store passed value
            drinkViewController.passedValue = valueToPass
            // declare myArray in your drinkViewController and then assign it here
            // now your array that you passed will be available through myArray
            //drinkViewController.passedValue = sender
            drinkViewController.passedValue = sender as! Drinks
        }
    }
}
