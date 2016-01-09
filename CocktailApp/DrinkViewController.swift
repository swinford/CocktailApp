//
//  DrinkViewController.swift
//  CocktailApp
//
//  Created by Zachary Swinford on 1/8/16.
//  Copyright © 2016 Swinford. All rights reserved.
//

import UIKit

class DrinkViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var DrinkNameLabel: UILabel!
    @IBOutlet weak var DrinkInstructions: UILabel!
    @IBOutlet weak var DrinkGlass: UILabel!
    @IBOutlet weak var DrinkType: UILabel!
    @IBOutlet weak var DrinkImage: UIImageView!
    @IBOutlet weak var DrinkAlcoholic: UILabel!
    @IBOutlet weak var IngredientTableView: UITableView!
    
    var passedValue : SearchViewController.Drinks!
    var IngredientArray:Array< String > = Array < String >()
    var MeasurementtArray:Array< String > = Array < String >()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DrinkNameLabel.text = passedValue!.strDrink
        DrinkInstructions.text = passedValue!.strInstructions
        DrinkGlass.text = passedValue!.strGlass
        DrinkType.text = passedValue!.strCategory
        DrinkAlcoholic.text = passedValue!.strAlcoholic
        
        let imageString = passedValue!.strDrinkThumb
        if (imageString == ""){
            let noDrinkImage : UIImage = UIImage(named: "noimage.jpg")!
            DrinkImage.image = noDrinkImage
        }else{
            let drinkImage =  UIImage(data: NSData(contentsOfURL: NSURL(string:passedValue!.strDrinkThumb)!)!)
            DrinkImage.image = drinkImage
        }
        
        if(passedValue!.strIngredient1.isEmpty || passedValue!.strIngredient1 != " "){
            IngredientArray.append(passedValue!.strIngredient1)
        }
        if(passedValue!.strIngredient2.isEmpty || passedValue!.strIngredient2 != " "){
            IngredientArray.append(passedValue!.strIngredient2)
        }
        if(passedValue!.strIngredient3.isEmpty || passedValue!.strIngredient3 != " "){
        IngredientArray.append(passedValue!.strIngredient3)
        }
        if(passedValue!.strIngredient4.isEmpty || passedValue!.strIngredient4 != " "){
            IngredientArray.append(passedValue!.strIngredient4)
        }
        if(passedValue!.strIngredient5.isEmpty || passedValue!.strIngredient5 != " "){
            IngredientArray.append(passedValue!.strIngredient5)
        }
        if(passedValue!.strIngredient6.isEmpty || passedValue!.strIngredient6 != " "){
            IngredientArray.append(passedValue!.strIngredient6)
        }
        if(passedValue!.strIngredient7.isEmpty || passedValue!.strIngredient7 != " "){
            IngredientArray.append(passedValue!.strIngredient7)
        }
        if(passedValue!.strIngredient8.isEmpty || passedValue!.strIngredient8 != " "){
            IngredientArray.append(passedValue!.strIngredient8)
        }
        if(passedValue!.strIngredient9.isEmpty || passedValue!.strIngredient9 != " "){
            IngredientArray.append(passedValue!.strIngredient9)
        }
        if(passedValue!.strIngredient10.isEmpty || passedValue!.strIngredient10 != " "){
            IngredientArray.append(passedValue!.strIngredient10)
        }
        if(passedValue!.strIngredient11.isEmpty || passedValue!.strIngredient11 != " "){
            IngredientArray.append(passedValue!.strIngredient11)
        }
        if(passedValue!.strIngredient12.isEmpty || passedValue!.strIngredient12 != " "){
            IngredientArray.append(passedValue!.strIngredient12)
        }
        if(passedValue!.strIngredient13.isEmpty || passedValue!.strIngredient13 != " "){
            IngredientArray.append(passedValue!.strIngredient13)
        }
        if(passedValue!.strIngredient14.isEmpty || passedValue!.strIngredient14 != " "){
            IngredientArray.append(passedValue!.strIngredient14)
        }
        if(passedValue!.strIngredient15.isEmpty || passedValue!.strIngredient15 != " "){
            IngredientArray.append(passedValue!.strIngredient15)
        }
        
        MeasurementtArray.append(passedValue!.strMeasure1)
        MeasurementtArray.append(passedValue!.strMeasure2)
        MeasurementtArray.append(passedValue!.strMeasure3)
        MeasurementtArray.append(passedValue!.strMeasure4)
        MeasurementtArray.append(passedValue!.strMeasure5)
        MeasurementtArray.append(passedValue!.strMeasure6)
        MeasurementtArray.append(passedValue!.strMeasure7)
        MeasurementtArray.append(passedValue!.strMeasure8)
        MeasurementtArray.append(passedValue!.strMeasure9)
        MeasurementtArray.append(passedValue!.strMeasure10)
        MeasurementtArray.append(passedValue!.strMeasure11)
        MeasurementtArray.append(passedValue!.strMeasure12)
        MeasurementtArray.append(passedValue!.strMeasure13)
        MeasurementtArray.append(passedValue!.strMeasure14)
        MeasurementtArray.append(passedValue!.strMeasure15)
        
        self.IngredientTableView.delegate = self
        self.IngredientTableView.dataSource = self
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return IngredientArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("IngredientCell", forIndexPath: indexPath)
        cell.textLabel?.text = IngredientArray[indexPath.row]
        cell.detailTextLabel?.text = MeasurementtArray[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }

}
