//
//  BACViewController.swift
//  CocktailApp
//
//  Created by Zachary Swinford on 12/27/15.
//  Copyright © 2015 Swinford. All rights reserved.
//

import UIKit
import Foundation
import QuartzCore

class BACViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate {
    var BAC: Double = 0.00
    var beers: Int = 0
    var wine: Int = 0
    var shots: Int = 0
    @IBOutlet weak var gender: UISegmentedControl!
    @IBOutlet weak var weight: UIPickerView!
    let weightData = ["50", "60" ,"70", "80", "90", "100"]
    @IBOutlet weak var weightLabel: UILabel!
    
    let male: Double = 0.73
    let female: Double = 0.66
    let beerABV: Double = 0.045
    let wineABV: Double = 0.116
    let shotABV: Double = 0.37
    
    @IBOutlet weak var TextViewTime: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weight.dataSource = self
        weight.delegate = self
    }

    @IBAction func editTimeButton(sender: UIButton) {
        DatePickerDialog().show("Begin Time", doneButtonTitle: "Done", cancelButtonTitle: "Cancel", datePickerMode: .Time) {
            (date) -> Void in
            self.TextViewTime.text = self.convertDate(date)
        }
    }
    
    func convertDate(date: NSDate) -> String
    {
        let DateFormatter = NSDateFormatter()
        DateFormatter.timeStyle = .ShortStyle
        let temp = DateFormatter.stringFromDate(date)
        return temp
    }

    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return weightData[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        weightLabel.text = weightData[row]
    }
    
    func addShot()
    {
        shots++
    }
    
    func addBeer()
    {
        beers++
    }
    
    func addWine()
    {
        wine++
    }
    
    func subShot()
    {
        shots--
    }
    
    func subBeer()
    {
        beers--
    }
    
    func subWine()
    {
        wine--
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
    //MARK: - Delegates and data sources
    //MARK: Data Sources
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return weightData.count
    }
}
