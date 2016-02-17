//
//  ViewController.swift
//  CocktailApp
//
//  Created by Zachary Swinford on 12/27/15.
//  Copyright © 2015 Swinford. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var RandomDrinkName: UILabel!
    @IBOutlet weak var RandomDrinkButton: UIButton!
    @IBOutlet weak var navigationBar: UINavigationItem!

    var TableData:Array< RandomDrink > = Array < RandomDrink >()
    
    var drinkToPass: RandomDrink!
    let adrink = RandomDrink()
    var indicator = UIActivityIndicatorView()
    
    
    class RandomDrink {
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
    
    override func canBecomeFirstResponder() -> Bool {
        return true
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //RandomDrinkButton.addTarget(self, action: "RandomDrinkButtonPressed:", forControlEvents: .TouchUpInside)
        
        //SearchButton.backgroundColor = UIColor.grayColor()
//        SearchButton.layer.cornerRadius = 3
//        SearchButton.layer.borderWidth = 1
//        SearchButton.layer.borderColor = UIColor.blackColor().CGColor
//        //StoreButton.backgroundColor = UIColor.grayColor()
//        StoreButton.layer.cornerRadius = 3
//        StoreButton.layer.borderWidth = 1
//        StoreButton.layer.borderColor = UIColor.blackColor().CGColor
//        //BACButton.backgroundColor = UIColor.grayColor()
//        BACButton.layer.cornerRadius = 3
//        BACButton.layer.borderWidth = 1
//        BACButton.layer.borderColor = UIColor.blackColor().CGColor
//        //CabinetButton.backgroundColor = UIColor.grayColor()
//        CabinetButton.layer.cornerRadius = 3
//        CabinetButton.layer.borderWidth = 1
//        CabinetButton.layer.borderColor = UIColor.blackColor().CGColor
//        //GeniusButton.backgroundColor = UIColor.grayColor()
//        GeniusButton.layer.cornerRadius = 3
//        GeniusButton.layer.borderWidth = 1
//        GeniusButton.layer.borderColor = UIColor.blackColor().CGColor
//        let imageView = self.RandomDrinkImage
//        let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:Selector("imageTapped:"))
        //imageView.userInteractionEnabled = true
        //imageView.addGestureRecognizer(tapGestureRecognizer)
        
        RandomDrinkButton.addTarget(self, action: "randomButtonPressed:", forControlEvents: .TouchUpInside)

        
        let postEndpoint: String = "http://www.thecocktaildb.com/api/json/v1/1/random.php"
        
        activityIndicator()
        indicator.startAnimating()
        indicator.backgroundColor = UIColor.clearColor()
        
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
                    if let strDrink = drink["strDrink"] as? String {
                        print(String(count) + ". " + strDrink)
                        self.adrink.strDrink = strDrink
                        count++
                    }
                    if let strDrinkThumb = drink["strDrinkThumb"] as? String {
                        print("    " + strDrinkThumb)
                        self.adrink.strDrinkThumb = strDrinkThumb
                    }
                    if let strGlass = drink["strGlass"] as? String {
                        self.adrink.strGlass = strGlass
                    }
                    if let strCategory = drink["strCategory"] as? String {
                        self.adrink.strCategory = strCategory
                    }
                    if let strAlcoholic = drink["strAlcoholic"] as? String {
                        self.adrink.strAlcoholic = strAlcoholic
                    }
                    if let strInstructions = drink["strInstructions"] as? String {
                        self.adrink.strInstructions = strInstructions
                    }
                    if let strIngredient1 = drink["strIngredient1"] as? String {
                        self.adrink.strIngredient1 = strIngredient1
                    }
                    if let strIngredient2 = drink["strIngredient2"] as? String {
                        self.adrink.strIngredient2 = strIngredient2
                    }
                    if let strIngredient3 = drink["strIngredient3"] as? String {
                        self.adrink.strIngredient3 = strIngredient3
                    }
                    if let strIngredient4 = drink["strIngredient4"] as? String {
                        self.adrink.strIngredient4 = strIngredient4
                    }
                    if let strIngredient5 = drink["strIngredient5"] as? String {
                        self.adrink.strIngredient5 = strIngredient5
                    }
                    if let strIngredient6 = drink["strIngredient6"] as? String {
                        self.adrink.strIngredient6 = strIngredient6
                    }
                    if let strIngredient7 = drink["strIngredient7"] as? String {
                        self.adrink.strIngredient7 = strIngredient7
                    }
                    if let strIngredient8 = drink["strIngredient8"] as? String {
                        self.adrink.strIngredient8 = strIngredient8
                    }
                    if let strIngredient9 = drink["strIngredient9"] as? String {
                        self.adrink.strIngredient9 = strIngredient9
                    }
                    if let strIngredient10 = drink["strIngredient10"] as? String {
                        self.adrink.strIngredient10 = strIngredient10
                    }
                    if let strIngredient11 = drink["strIngredient11"] as? String {
                        self.adrink.strIngredient11 = strIngredient11
                    }
                    if let strIngredient12 = drink["strIngredient12"] as? String {
                        self.adrink.strIngredient12 = strIngredient12
                    }
                    if let strIngredient13 = drink["strIngredient13"] as? String {
                        self.adrink.strIngredient13 = strIngredient13
                    }
                    if let strIngredient14 = drink["strIngredient14"] as? String {
                        self.adrink.strIngredient14 = strIngredient14
                    }
                    if let strIngredient15 = drink["strIngredient15"] as? String {
                        self.adrink.strIngredient15 = strIngredient15
                    }
                    if let strMeasure1 = drink["strMeasure1"] as? String {
                        self.adrink.strMeasure1 = strMeasure1
                    }
                    if let strMeasure2 = drink["strMeasure2"] as? String {
                        self.adrink.strMeasure2 = strMeasure2
                    }
                    if let strMeasure3 = drink["strMeasure3"] as? String {
                        self.adrink.strMeasure3 = strMeasure3
                    }
                    if let strMeasure4 = drink["strMeasure4"] as? String {
                        self.adrink.strMeasure4 = strMeasure4
                    }
                    if let strMeasure5 = drink["strMeasure5"] as? String {
                        self.adrink.strMeasure5 = strMeasure5
                    }
                    if let strMeasure6 = drink["strMeasure6"] as? String {
                        self.adrink.strMeasure6 = strMeasure6
                    }
                    if let strMeasure7 = drink["strMeasure7"] as? String {
                        self.adrink.strMeasure7 = strMeasure7
                    }
                    if let strMeasure8 = drink["strMeasure8"] as? String {
                        self.adrink.strMeasure8 = strMeasure8
                    }
                    if let strMeasure9 = drink["strMeasure9"] as? String {
                        self.adrink.strMeasure9 = strMeasure9
                    }
                    if let strMeasure10 = drink["strMeasure10"] as? String {
                        self.adrink.strMeasure10 = strMeasure10
                    }
                    if let strMeasure11 = drink["strMeasure11"] as? String {
                        self.adrink.strMeasure11 = strMeasure11
                    }
                    if let strMeasure12 = drink["strMeasure12"] as? String {
                        self.adrink.strMeasure12 = strMeasure12
                    }
                    if let strMeasure13 = drink["strMeasure13"] as? String {
                        self.adrink.strMeasure13 = strMeasure13
                    }
                    if let strMeasure14 = drink["strMeasure14"] as? String {
                        self.adrink.strMeasure14 = strMeasure14
                    }
                    if let strMeasure15 = drink["strMeasure15"] as? String {
                        self.adrink.strMeasure15 = strMeasure15
                    }
                    self.TableData.append(self.adrink)
                    //self.RandomDrinkName.text = self.adrink.strDrink
                    
                    self.drinkToPass = self.adrink
                    let imageString = self.adrink.strDrinkThumb
                    let drinkName = self.adrink.strDrink
                    
                    self.navigationItem.title  = drinkName
                    
                    if (imageString == ""){
                        let noDrinkImage : UIImage = UIImage(named: "noimage.jpg")!
                        self.RandomDrinkButton.setImage(noDrinkImage, forState: UIControlState.Normal)
                        self.indicator.stopAnimating()
                        self.indicator.hidesWhenStopped = true
                        
                    }else{
                        let drinkImage =  UIImage(data: NSData(contentsOfURL: NSURL(string:self.adrink.strDrinkThumb)!)!)
                        self.RandomDrinkButton.setBackgroundImage(drinkImage, forState: .Normal)
                        self.indicator.stopAnimating()
                        self.indicator.hidesWhenStopped = true
                    }
                }
            }
        
        })
        task.resume()
    }
    
    @IBAction func randomButtonPressed(sender: UIButton)
    {
        self.performSegueWithIdentifier("RandomDrinkSegue", sender: adrink)
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "RandomDrinkSegue") {

            let drinkViewController = segue.destinationViewController as! DrinkViewController
            drinkViewController.randomDrinkValue = drinkToPass
            drinkViewController.randomDrinkValue = sender as! RandomDrink
        }
    }
    func activityIndicator(){
        indicator = UIActivityIndicatorView(frame: CGRectMake(80, 80, 80, 80))
        indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        indicator.center = self.RandomDrinkButton.center
        self.view.addSubview(indicator)
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

