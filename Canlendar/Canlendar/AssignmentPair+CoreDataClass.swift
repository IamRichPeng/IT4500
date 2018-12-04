//
//  AssignmentPair+CoreDataClass.swift
//  Canlendar
//
//  Created by KirtisOrendorff on 12/4/18.
//  Copyright © 2018 Ruicheng Peng. All rights reserved.
//
//

import Foundation
import CoreData

@objc(AssignmentPair)
public class AssignmentPair: NSManagedObject {
    var date: Date?{
        get{
            return rawDate as Date?
        }
        set{
            rawDate = newValue as NSDate?
        }
    }
    convenience init?(name: String?, durationTime: Double, date: Date?) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        guard  let managedContext = appDelegate?.persistentContainer.viewContext else{
            return nil
        }
        
        self.init(entity: AssignmentPair.entity(), insertInto: managedContext)
        
        self.name = name
        self.durationTime = durationTime
        self.date = date
    }
}
