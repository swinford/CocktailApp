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
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)

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
