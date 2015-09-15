//
//  Dish.swift
//  Nummy_Bus
//
//  Created by Ralph Wang on 2015-09-12.
//  Copyright (c) 2015 Cheng Sun. All rights reserved.
//

import Foundation
import CoreData

class Dish: NSManagedObject {

    @NSManaged var dName: String
    @NSManaged var dNote: String
    @NSManaged var dPrice: String

}
