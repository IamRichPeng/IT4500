
//
//  AssignmentVars.swift
//  Canlendar
//
//  Created by KirtisOrendorff on 11/30/18.
//  Copyright © 2018 Ruicheng Peng. All rights reserved.
//


//  This file is for pairing created assignments by this app to the EKEvent collection
//      in order to shuffle or assign time slots for assignments that do not have a
//      static start time/date.

import Foundation
import EventKit

//class needs to contain:
//      -Title
//      -Duration
//      -Due Date
//      -Start Date(NULL IF NOT ALREADY ASSIGNED)
class AssignmentPicker{
    var title: String?
    var duration: TimeInterval?
    var dueDate: Date?
    var startDate: Date?
    
    init (title: String, duration: TimeInterval, dueDate: Date){
        self.title = title
        self.duration = duration
        self.dueDate = dueDate
    }
    
    
    
    //need to find a time slot to place new assignment, must be before due date OTHERWISE reshuffle all assignments

    //need to keep track of assignments we create
    func createPair(){
        //selectTimeForAssignments()
    }
    
    func selectTimeForAssignment() -> EKEvent{
        //find gap in Calendars where nothing is happening for the duration timeInterval
        
        //TO CHECK FOR GAPS
            //start from today to dueDate
            //example: event 1 at 2pm->3pm, event 2 at 5pm->6pm, event 3 at 8pm->9pm
            //find timeInterval from event 1 endDate to event 2 start date
            //if that interval is less than or equal to duration, assign assignment there, else check event 2 and 3
            //if we get to dueDate without assigning, need to shuffle all assignment events
        
        let currentDate = Date()
        var relevantEvents = [EKEvent]()
        
        //find all events between now and due date
        for event in events{
            if event.startDate < currentDate {
                if event.startDate > dueDate!{
                    relevantEvents.append(event)
                }
            }
        }
        
        if relevantEvents.isEmpty{
            //add event right now
            let event = EKEvent()
            
            event.title = title
            event.startDate = currentDate
            event.endDate = event.startDate + duration!
            event.notes = "Dynmically added assignment by Bluprnt"
            
            return event
        }
        
        var i = 0
        for event in relevantEvents{
            //find gaps between events
            if relevantEvents.count > i - 2{
                if relevantEvents[i + 1].startDate.timeIntervalSince(event.endDate) > duration!{
                    let event = EKEvent()
                    
                    event.title = title
                    event.startDate = relevantEvents[i].endDate
                    event.endDate = event.startDate + duration!
                    event.notes = "Dynmically added assignment by Bluprnt"
                    
                    return event
                }
            }
        }
        
        if relevantEvents[relevantEvents.count - 1].endDate.timeIntervalSince(dueDate!) > duration!{
            //add event at end time of last relevant event
            let event = EKEvent()
            
            event.title = title
            event.startDate = relevantEvents[relevantEvents.count - 1].endDate
            event.endDate = event.startDate + duration!
            event.notes = "Dynmically added assignment by Bluprnt"
            
            return event
        }
        
        //shouldnt get here
        let event = EKEvent()
        
        event.title = title
        event.startDate = relevantEvents[relevantEvents.count - 1].endDate
        event.endDate = event.startDate + duration!
        event.notes = "Dynmically added assignment by Bluprnt"
        return event
    }
}





