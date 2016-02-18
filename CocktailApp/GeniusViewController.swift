//
//  GeniusViewController.swift
//  CocktailApp
//
//  Created by Zachary Swinford on 12/27/15.
//  Copyright © 2015 Swinford. All rights reserved.
//

import UIKit
import CoreData

class GeniusViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var TableView: UITableView!
    
    let ingredientFetch = NSFetchRequest(entityName: "Cabinet")
    let moc = DataController().managedObjectContext
    var fetchedIngredient = [Cabinet]()
    
    var checkedIngredients = [String]()
    
    @IBOutlet weak var GeniusButton: UIButton!
    @IBOutlet weak var ResetButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        TableView.delegate = self
        TableView.dataSource = self
        TableView.registerClass(UITableViewCell.self,
            forCellReuseIdentifier: "Cell")
        // fetch Core Data
        do{
            fetchedIngredient = try moc.executeFetchRequest(ingredientFetch) as! [Cabinet]           
//            print(fetchedIngredient.first!.ingredient)
//            print(fetchedIngredient.last!.ingredient)
        } catch {
            fatalError()
        }
        GeniusButton.addTarget(self, action: "genius:", forControlEvents: .TouchUpInside)
        ResetButton.addTarget(self, action: "resetChecks:", forControlEvents: .TouchUpInside)
    
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return fetchedIngredient.capacity
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        do{
            fetchedIngredient = try moc.executeFetchRequest(ingredientFetch) as! [Cabinet]
            cell.textLabel?.text = fetchedIngredient[indexPath.row].ingredient

        } catch {
            fatalError("bad things happened: \(error)")
        }

        
//        if checked[indexPath.row] == false {
//            
//            cell.accessoryType = .None
//        }
//        else if checked[indexPath.row] == true {
//            
//            cell.accessoryType = .Checkmark
//        }
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        if let cell = TableView.cellForRowAtIndexPath(indexPath) {
            if cell.accessoryType == .Checkmark
            {
                cell.accessoryType = .None
                checkedIngredients = checkedIngredients.filter() { $0 != fetchedIngredient[indexPath.row].ingredient }
            }
            else
            {
                cell.accessoryType = .Checkmark
                checkedIngredients.append(fetchedIngredient[indexPath.row].ingredient!)
            }
        }
    }

    func genius(sender:UIButton!)
    {
        for items in checkedIngredients {
            print(items)
        }
//        // create the alert
//        let alert = UIAlertController(title: "Added!", message: "You've added " + TextUI.text! + " to your cabinet", preferredStyle: UIAlertControllerStyle.Alert)
//        // add an action (button)
//        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
//        // show the alert
//        self.presentViewController(alert, animated: true, completion: nil)
    }

    func resetChecks(sender:UIButton!)
    {
        for i in 0...TableView.numberOfSections-1
        {
            for j in 0...TableView.numberOfRowsInSection(i)-1
            {
                if let cell = TableView.cellForRowAtIndexPath(NSIndexPath(forRow: j, inSection: i)) {
                    cell.accessoryType = .None
                    checkedIngredients.removeAll()
                }
                
            }
        }
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
