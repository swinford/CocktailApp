//
//  BAC+CoreDataProperties.swift
//  CocktailApp
//
//  Created by Brian Crosser on 2/18/16.
//  Copyright © 2016 Swinford. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension BAC {

    @NSManaged var wine: NSNumber?
    @NSManaged var beers: NSNumber?
    @NSManaged var shots: NSNumber?
    @NSManaged var time: NSDate?
    @NSManaged var weight: NSNumber?
    @NSManaged var gender: NSNumber?
    @NSManaged var bac: NSNumber?

}
