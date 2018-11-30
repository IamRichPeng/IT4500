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

//need to find a time slot to place new assignment, must be before due date OTHERWISE reshuffle all assignments

//need to keep track of assignments we create
func createPair(){
    //selectTimeForAssignments()
}

func selectTimeForAssignment(){
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



