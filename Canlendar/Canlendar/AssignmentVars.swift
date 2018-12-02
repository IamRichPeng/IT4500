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
class EventPair{
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
    
    func selectTimeForAssignment(){
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
        
        for event in relevantEvents{
            var i = event.index(ofAccessibilityElement: event)
            if i + 1 <= relevantEvents.count{
                //find time interval between this event and next
                let interval = relevantEvents[i+1].startDate.timeIntervalSince(event.endDate)
                if interval > duration!{
                    //events.append(nil) //TODO TODO TODO create new event with start date = event.endDate
                }
            }
            else if event.endDate > dueDate!{
                let interval = relevantEvents[i+1].startDate.timeIntervalSince(event.endDate)
                if interval > duration!{
                    //events.append(nil) //TODO TODO TODO create new event with start date = event.endDate
                }
            }
        }
        
        
        //if assignment cannot have a time selected, shuffleAssignments()
    }
    
    //need to shuffle assignments if conflicts arise from due date
    func shuffleAssignments(){
        //findAssignments()
    }
    
    //need to search for all pairs we've created
    func findAssignments(){
        //check if user has deleted assignments in Apple Calendars, removeDeletedAssignments()
        //place assignments according to due date,
    }
    
    //places assignments in the calendar when events are not scheduled, ordered by due date
    func assignTimeForAssignments(){
        
    }
    
    //removes our local tracker of an assignment in case of user deleting the assignment in Apple Calendar
    func removeDeletedAssignments(){
        
    }
}





