//
//  Dish.swift
//  
//
//  Created by Ralph Wang on 2015-09-11.
//
//

import Foundation
import CoreData

class Dish: NSManagedObject {

    @NSManaged var dName: String
    @NSManaged var dPrice: String
    @NSManaged var dNote: String

}
