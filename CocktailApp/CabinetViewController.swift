//
//  CabinetViewController.swift
//  CocktailApp
//
//  Created by Zachary Swinford on 12/27/15.
//  Copyright © 2015 Swinford. All rights reserved.
//

import UIKit
import CoreData

class CabinetViewController: UIViewController, UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate {

    var ingredientArray = [String]()
    var display = [String]()
    var dbIngredients = [String]()
    
    let ingredientFetch = NSFetchRequest(entityName: "Cabinet")
    var fetchedIngredient = [Cabinet]()
    
    @IBOutlet weak var TextUI: UITextField!
    @IBOutlet weak var Button: UIButton!
    @IBOutlet weak var TableView: UITableView!
    
    let moc = DataController().managedObjectContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TextUI.delegate = self
        TextUI.addTarget(self, action: "textFieldDidChange:", forControlEvents: UIControlEvents.EditingChanged)
        
        TableView.delegate = self
        TableView.dataSource = self
        TableView.registerClass(UITableViewCell.self,
            forCellReuseIdentifier: "Cell")
        
        // fetch Core Data
        do{
            fetchedIngredient = try moc.executeFetchRequest(ingredientFetch) as! [Cabinet]
        } catch {
            fatalError()
        }
        
        let postEndpoint: String = "http://www.thecocktaildb.com/api/json/v1/1/list.php?i=list"
        
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
                    if let strIngredient = drink["strIngredient1"] as? String {
                        print(String(count) + ". " + strIngredient)
                        self.dbIngredients.append(strIngredient)
                        count++
                    }
                }
            }
        })
        task.resume()
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.TableView.reloadData()
        })
    }

    func textFieldDidChange(textField: UITextField) {
        search(self.TextUI.text!)
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        Button.addTarget(self, action: "buttonPressed:", forControlEvents: .TouchUpInside)
        return true
    }
    
    func buttonPressed(sender: UIButton!) {
        //ingredientArray.append(TextUI.text!)

        let entity = NSEntityDescription.insertNewObjectForEntityForName("Cabinet", inManagedObjectContext: moc) as! Cabinet
        entity.setValue(TextUI.text!, forKey: "ingredient")
        do{
            try moc.save()
        }catch {
            fatalError("failure to save context: \(error)")
        }
        showAlertButtonTapped(Button)

        do{
            fetchedIngredient = try moc.executeFetchRequest(ingredientFetch) as! [Cabinet]
            self.TableView.beginUpdates()
            let totalIngredients = fetchedIngredient.count
            let newItemIndexPath = NSIndexPath(forRow: totalIngredients-1, inSection: 0)
            self.TableView.insertRowsAtIndexPaths([newItemIndexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
            self.TableView.endUpdates()
        } catch {
            fatalError()
        }
    }
    
    @IBAction func showAlertButtonTapped(sender: UIButton) {
        // create the alert
        let alert = UIAlertController(title: "Added!", message: "You've added " + TextUI.text! + " to your cabinet", preferredStyle: UIAlertControllerStyle.Alert)
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        // show the alert
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func search(str:String) {
        display.removeAll(keepCapacity: false)
        
        for s in dbIngredients{
            if s.hasPrefix(str){
                display.append(s)
                print(s)
            }
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedIngredient.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        cell.textLabel?.text = fetchedIngredient[indexPath.row].ingredient
        return cell
    }

    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let alert = UIAlertController(title: "Remove " + fetchedIngredient[indexPath.row].ingredient!,
            message: "No more " + fetchedIngredient[indexPath.row].ingredient! + " in your cabinet?",
            preferredStyle: .Alert)
        
        let deleteAction = UIAlertAction(title: "Remove",
            style: .Default,
            handler: { (action:UIAlertAction) -> Void in
                self.fetchedIngredient.removeAtIndex(indexPath.row)
                
                do{
                    let fetchedResults = try self.moc.executeFetchRequest(self.ingredientFetch)
                    if let result = fetchedResults[indexPath.row] as? NSManagedObject {
                        self.moc.deleteObject(result)
                        try self.moc.save()
                        self.TableView.beginUpdates()
                        let itemIndexPath = NSIndexPath(forRow: indexPath.row, inSection: 0)
                        self.TableView.deleteRowsAtIndexPaths([itemIndexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
                        self.TableView.endUpdates()
                    }
                }catch{
                    fatalError()
                }
                
        })
        
        let cancelAction = UIAlertAction(title: "Cancel",
            style: .Default) { (action: UIAlertAction) -> Void in
        }
        
        alert.addAction(cancelAction)
        alert.addAction(deleteAction)
        
        presentViewController(alert,
            animated: true,
            completion: nil)
        TableView.reloadData()
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
