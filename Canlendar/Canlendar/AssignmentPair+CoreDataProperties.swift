//
//  AssignmentPair+CoreDataProperties.swift
//  Canlendar
//
//  Created by KirtisOrendorff on 12/4/18.
//  Copyright © 2018 Ruicheng Peng. All rights reserved.
//
//

import Foundation
import CoreData


extension AssignmentPair {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AssignmentPair> {
        return NSFetchRequest<AssignmentPair>(entityName: "AssignmentPair")
    }

    @NSManaged public var name: String?
    @NSManaged public var durationTime: Double
    @NSManaged public var rawDate: NSDate?

}
