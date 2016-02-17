//
//  DrinkViewController.swift
//  CocktailApp
//
//  Created by Zachary Swinford on 1/8/16.
//  Copyright © 2016 Swinford. All rights reserved.
//

import UIKit
import CoreData

class DrinkViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var DrinkNameLabel: UILabel!
    @IBOutlet weak var DrinkInstructions: UILabel!
    @IBOutlet weak var DrinkGlass: UILabel!
    @IBOutlet weak var DrinkType: UILabel!
    @IBOutlet weak var DrinkImage: UIImageView!
    @IBOutlet weak var DrinkAlcoholic: UILabel!
    @IBOutlet weak var IngredientTableView: UITableView!
    @IBOutlet weak var DrinkNavigation: UINavigationItem!
    @IBOutlet weak var instructionScrollView: UIScrollView!
    @IBOutlet weak var heartButton: UIButton!
    
    var passedValue : SearchViewController.Drinks!
    var randomDrinkValue : ViewController.RandomDrink!
    
    var IngredientArray:Array< String > = Array < String >()
    var MeasurementtArray:Array< String > = Array < String >()
    
    var heartSelected:Bool!
    
    let moc = DataController().managedObjectContext
    var favoriteCocktails = [Favorites]()
    let cocktailFetch = NSFetchRequest(entityName: "Favorites")

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        heartButton.setImage(UIImage(named: "outlineHeart.png")!, forState: UIControlState.Normal)
        heartSelected = false
        heartButton.addTarget(self, action: "heartPressed:", forControlEvents:UIControlEvents.TouchUpInside)
        
        if (passedValue != nil){
            DrinkNavigation.title = passedValue!.strDrink
            DrinkInstructions.text = passedValue!.strInstructions
            DrinkGlass.text = passedValue!.strGlass
            DrinkType.text = passedValue!.strCategory
            //DrinkAlcoholic.text = passedValue!.strAlcoholic
            
//            instructionScrollView.contentSize.height = DrinkInstructions.frame.size.height
//            instructionScrollView.contentSize.width = DrinkInstructions.frame.size.width
//            instructionScrollView.addSubview(DrinkInstructions)
//            view.addSubview(instructionScrollView)
            
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
            
            
        }
        else {
            
            DrinkNavigation.title = randomDrinkValue!.strDrink
            DrinkInstructions.text = randomDrinkValue!.strInstructions
            DrinkGlass.text = randomDrinkValue!.strGlass
            DrinkType.text = randomDrinkValue!.strCategory
            //DrinkAlcoholic.text = randomDrinkValue!.strAlcoholic
            
//            instructionScrollView.contentSize.height = DrinkInstructions.frame.size.height
//            instructionScrollView.contentSize.width = DrinkInstructions.frame.size.width
//            instructionScrollView.addSubview(DrinkInstructions)
//            view.addSubview(instructionScrollView)
            
            let imageString = randomDrinkValue!.strDrinkThumb
            if (imageString == ""){
                let noDrinkImage : UIImage = UIImage(named: "noimage.jpg")!
                DrinkImage.image = noDrinkImage
            }else{
                let drinkImage =  UIImage(data: NSData(contentsOfURL: NSURL(string:randomDrinkValue!.strDrinkThumb)!)!)
                DrinkImage.image = drinkImage
            }
            
            if(randomDrinkValue!.strIngredient1.isEmpty || randomDrinkValue!.strIngredient1 != " "){
                IngredientArray.append(randomDrinkValue!.strIngredient1)
            }
            if(randomDrinkValue!.strIngredient2.isEmpty || randomDrinkValue!.strIngredient2 != " "){
                IngredientArray.append(randomDrinkValue!.strIngredient2)
            }
            if(randomDrinkValue!.strIngredient3.isEmpty || randomDrinkValue!.strIngredient3 != " "){
                IngredientArray.append(randomDrinkValue!.strIngredient3)
            }
            if(randomDrinkValue!.strIngredient4.isEmpty || randomDrinkValue!.strIngredient4 != " "){
                IngredientArray.append(randomDrinkValue!.strIngredient4)
            }
            if(randomDrinkValue!.strIngredient5.isEmpty || randomDrinkValue!.strIngredient5 != " "){
                IngredientArray.append(randomDrinkValue!.strIngredient5)
            }
            if(randomDrinkValue!.strIngredient6.isEmpty || randomDrinkValue!.strIngredient6 != " "){
                IngredientArray.append(randomDrinkValue!.strIngredient6)
            }
            if(randomDrinkValue!.strIngredient7.isEmpty || randomDrinkValue!.strIngredient7 != " "){
                IngredientArray.append(randomDrinkValue!.strIngredient7)
            }
            if(randomDrinkValue!.strIngredient8.isEmpty || randomDrinkValue!.strIngredient8 != " "){
                IngredientArray.append(randomDrinkValue!.strIngredient8)
            }
            if(randomDrinkValue!.strIngredient9.isEmpty || randomDrinkValue!.strIngredient9 != " "){
                IngredientArray.append(randomDrinkValue!.strIngredient9)
            }
            if(randomDrinkValue!.strIngredient10.isEmpty || randomDrinkValue!.strIngredient10 != " "){
                IngredientArray.append(randomDrinkValue!.strIngredient10)
            }
            if(randomDrinkValue!.strIngredient11.isEmpty || randomDrinkValue!.strIngredient11 != " "){
                IngredientArray.append(randomDrinkValue!.strIngredient11)
            }
            if(randomDrinkValue!.strIngredient12.isEmpty || randomDrinkValue!.strIngredient12 != " "){
                IngredientArray.append(randomDrinkValue!.strIngredient12)
            }
            if(randomDrinkValue!.strIngredient13.isEmpty || randomDrinkValue!.strIngredient13 != " "){
                IngredientArray.append(randomDrinkValue!.strIngredient13)
            }
            if(randomDrinkValue!.strIngredient14.isEmpty || randomDrinkValue!.strIngredient14 != " "){
                IngredientArray.append(randomDrinkValue!.strIngredient14)
            }
            if(randomDrinkValue!.strIngredient15.isEmpty || randomDrinkValue!.strIngredient15 != " "){
                IngredientArray.append(randomDrinkValue!.strIngredient15)
            }
            
            MeasurementtArray.append(randomDrinkValue!.strMeasure1)
            MeasurementtArray.append(randomDrinkValue!.strMeasure2)
            MeasurementtArray.append(randomDrinkValue!.strMeasure3)
            MeasurementtArray.append(randomDrinkValue!.strMeasure4)
            MeasurementtArray.append(randomDrinkValue!.strMeasure5)
            MeasurementtArray.append(randomDrinkValue!.strMeasure6)
            MeasurementtArray.append(randomDrinkValue!.strMeasure7)
            MeasurementtArray.append(randomDrinkValue!.strMeasure8)
            MeasurementtArray.append(randomDrinkValue!.strMeasure9)
            MeasurementtArray.append(randomDrinkValue!.strMeasure10)
            MeasurementtArray.append(randomDrinkValue!.strMeasure11)
            MeasurementtArray.append(randomDrinkValue!.strMeasure12)
            MeasurementtArray.append(randomDrinkValue!.strMeasure13)
            MeasurementtArray.append(randomDrinkValue!.strMeasure14)
            MeasurementtArray.append(randomDrinkValue!.strMeasure15)
            
        }
        // Do any additional setup after loading the view, typically from a nib.
        self.IngredientTableView.delegate = self
        self.IngredientTableView.dataSource = self
    }
    
    func heartPressed(sender: UIButton) {
        if (heartSelected == false)
        {
            print("heart selected")
            heartSelected = true
            heartButton.setImage(UIImage(named:"selectedHeart.png"), forState:UIControlState.Normal)
            let entity = NSEntityDescription.insertNewObjectForEntityForName("Favorites", inManagedObjectContext: moc) as! Favorites
            entity.setValue(DrinkNavigation.title!, forKey: "cocktail")
            do{
                try moc.save()
            }catch {
                fatalError("failure to save context: \(error)")
            }
        }
        else{
            print("heart deselected")
            heartSelected = false
            heartButton.setImage(UIImage(named:"outlineHeart.png"), forState:UIControlState.Normal)
//            do{
//                let fetchedResults = try self.moc.executeFetchRequest(self.cocktailFetch)
//                if let result = fetchedResults as? NSManagedObject {
//                    self.moc.deleteObject(result)
//                    try self.moc.save()
//                }
//            }
//            catch{
//                fatalError()
//            }

        }
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
