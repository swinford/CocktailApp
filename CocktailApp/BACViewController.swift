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
    @IBOutlet weak var invalidWeight: UILabel!
    var startDate: NSDate?
    @IBOutlet weak var gender: UISegmentedControl!
    @IBOutlet weak var weight: UIPickerView!
    var weightData = ["50", "60" ,"70", "80", "90", "100", "200"]
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
        shotControllerOutlet.minimumValue = 0
        beerControllerOutlet.minimumValue = 0
        wineControllerOutlet.minimumValue = 0
        invalidWeight.layer.cornerRadius = 5
    }
    
    @IBAction func editTimeButton(sender: UIButton) {
        DatePickerDialog().show("Begin Time", doneButtonTitle: "Done", cancelButtonTitle: "Cancel", datePickerMode: .Time) {
            (date) -> Void in
            self.TextViewTime.text = self.convertDate(date)
            self.startDate = date
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
    
    //Shots controller
    @IBOutlet weak var shots: UILabel!
    @IBOutlet weak var shotControllerOutlet: UIStepper!
    @IBAction func shotController(sender: UIStepper) {
        shots.text = Int(sender.value).description
    }

    //Beer controller
    @IBOutlet weak var beers: UILabel!
    @IBOutlet weak var beerControllerOutlet: UIStepper!
    
    @IBAction func beerController(sender: UIStepper) {
        beers.text = Int(sender.value).description
    }
    
    //Wine controller
    @IBOutlet weak var wine: UILabel!
    @IBOutlet weak var wineControllerOutlet: UIStepper!
    @IBAction func wineController(sender: UIStepper) {
        wine.text = Int(sender.value).description
    }
    
    @IBOutlet weak var bac: UILabel!
    @IBAction func calculateButton(sender: UIButton) {
        let currentDate = NSDate()
        
        let calendar = NSCalendar.currentCalendar()
        let comp = calendar.components([.Hour, .Minute], fromDate: startDate!)
        let hourStart = comp.hour
        let minuteStart = comp.minute
        
        let comp1 = calendar.components([.Hour, .Minute], fromDate: currentDate)
        let hourCurrent = comp1.hour
        let minuteCurrent = comp1.minute
        
        var minDif = (hourCurrent - hourStart) * 60
        minDif = minDif + minuteCurrent - minuteStart
        
        //Determines the gender of the user
        var genderMultiplier: Double
        if gender.selected == false{
            genderMultiplier = 0.73
        }
        else{
            genderMultiplier = 0.66
        }
        
        //Gets number or ounces consumed
        var abv = Double(beers.text!)! * 12 * beerABV
        abv = abv + Double(shots.text!)! * 1.5 * shotABV
        abv = abv + Double(wine.text!)! * 5 * wineABV
        
        //Gets weight
        var weightFinal: Double = 0.0
        if weightLabel.text! != "Weight"{
            weightFinal = Double(weightLabel.text!)!
        }
        else{
            invalidWeight.hidden = false
            sleep(5)
            invalidWeight.hidden = true
        }
        
        var bacNum: Double = abv * 5.14 / weightFinal * genderMultiplier
        bacNum = bacNum - 0.015 * Double(minDif)/60.0
        bacNum = round(1000 * bacNum) / 1000
        if bacNum < 0{
            bacNum = 0
        }
        bac.text = String(bacNum)
        
        if bacNum <= 0.03{
            bac.textColor = UIColor.greenColor()
        }
        else if bacNum <= 0.05 && bacNum > 0.03{
            bac.textColor = UIColor.yellowColor()
        }
        else{
            bac.textColor = UIColor.redColor()
        }
        
        bac.hidden = false
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
