//
//  CabinetViewController.swift
//  CocktailApp
//
//  Created by Zachary Swinford on 12/27/15.
//  Copyright © 2015 Swinford. All rights reserved.
//

import UIKit

class CabinetViewController: UIViewController, UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate {
    
    //let db = SQLiteDB.sharedInstance()
    var ingredientArray = [String]()
    
    @IBOutlet weak var TextUI: UITextField!
    @IBOutlet weak var Button: UIButton!
    @IBOutlet weak var TableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TextUI.delegate = self
        TableView.delegate = self
        TableView.dataSource = self
        TableView.registerClass(UITableViewCell.self,
            forCellReuseIdentifier: "Cell")
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        Button.addTarget(self, action: "buttonPressed:", forControlEvents: .TouchUpInside)
        return true
    }
    
    func buttonPressed(sender: UIButton!) {
        ingredientArray.append(TextUI.text!)
        TableView.reloadData()
        let userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setObject(ingredientArray, forKey:"ingredients")
        //userDefaults.synchronize()
    }
    
    func tableView(tableView: UITableView,
        numberOfRowsInSection section: Int) -> Int {
            return ingredientArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        cell.textLabel?.text = ingredientArray[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let alert = UIAlertController(title: "Remove " + ingredientArray[indexPath.row],
            message: "No more " + ingredientArray[indexPath.row] + " in your cabinet?",
            preferredStyle: .Alert)
        
        let deleteAction = UIAlertAction(title: "Remove",
            style: .Default,
            handler: { (action:UIAlertAction) -> Void in
    
                self.ingredientArray = self.ingredientArray.filter{$0 != self.ingredientArray[indexPath.row]}
                self.TableView.reloadData()
        })
        
        let cancelAction = UIAlertAction(title: "Cancel",
            style: .Default) { (action: UIAlertAction) -> Void in
        }
        
        alert.addAction(cancelAction)
        alert.addAction(deleteAction)
        
        presentViewController(alert,
            animated: true,
            completion: nil)
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
