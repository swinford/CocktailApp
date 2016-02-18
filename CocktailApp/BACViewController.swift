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
import CoreData

class BACViewController: UIViewController,UIPickerViewDelegate {
    var startDate: NSDate?
    @IBOutlet weak var gender: UISegmentedControl!
    
    let moc = DataController().managedObjectContext
    
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var editWeight: UITextField!
    
    let male: Double = 0.73
    let female: Double = 0.66
    let beerABV: Double = 0.045
    let wineABV: Double = 0.116
    let shotABV: Double = 0.37
    var weightFinal: Double = 0.0

    
    @IBOutlet weak var TextViewTime: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        shotControllerOutlet.minimumValue = 0
        beerControllerOutlet.minimumValue = 0
        wineControllerOutlet.minimumValue = 0
        let tapRecognizer = UITapGestureRecognizer()
        tapRecognizer.addTarget(self, action: "didTapView")
        self.view.addGestureRecognizer(tapRecognizer)
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
    
    func getWeight() ->Double {
        //Gets weight
        weightFinal = 0.0
        if editWeight.text != "" {
            weightFinal = Double(Int(self.editWeight.text!)!)
            return weightFinal
        }
        else{
            return -100.0
        }
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
        
        let weight: Double = getWeight()
        if weight != -100.0{
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
        
            var bacNum: Double = abv * 5.14 / weight * genderMultiplier
            bacNum = bacNum - 0.015 * Double(minDif)/60.0
            bacNum = round(1000 * bacNum) / 1000
            if bacNum < 0{
                bacNum = 0
            }
            bac.text = String(abs(bacNum))
            
            if bacNum <= 0.03{
                bac.textColor = UIColor.greenColor()
            }
            else if bacNum <= 0.05 && bacNum > 0.03{
                bac.textColor = UIColor.yellowColor()
            }
            else{
                bac.textColor = UIColor.redColor()
            }

        }
        else{
            bac.text = "Invalid Weight!"
            bac.textColor = UIColor.redColor()
        }
        
        bac.hidden = false
    }
    
    func didTapView(){
        self.view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
}



// MARK: - Navigation
// In a storyboard-based application, you will often want to do a little preparation before navigation
override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
// Get the new view controller using segue.destinationViewController.
// Pass the selected object to the new view controller.

    let entity = NSEntityDescription.insertNewObjectForEntityForName("BAC", inManagedObjectContext: moc) as! BAC
    entity.setValue(bac.text, forKey: "bac")
    entity.setValue(weightFinal, forKey: "gender")
    entity.setValue(shots.text, forKey: "shots")
    entity.setValue(beers.text, forKey: "beers")
    entity.setValue(wine.text, forKey: "wine")
    entity.setValue(startDate, forKey: "time")
    
    do{
        try moc.save()
    }catch {
        fatalError("failure to save context: \(error)")
    }

}



}
