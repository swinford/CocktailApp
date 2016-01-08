//
//  DrinkViewController.swift
//  CocktailApp
//
//  Created by Zachary Swinford on 1/8/16.
//  Copyright © 2016 Swinford. All rights reserved.
//

import UIKit

class DrinkViewController: UIViewController {
    
    @IBOutlet weak var DrinkNameLabel: UILabel!
    
    var passedValue : SearchViewController.Drinks!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DrinkNameLabel.text = passedValue!.strDrink
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
