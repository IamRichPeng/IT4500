//
//  EventVars.swift
//  Canlendar
//
//  Created by KirtisOrendorff on 11/28/18.
//  Copyright © 2018 Ruicheng Peng. All rights reserved.
//

import Foundation
import EventKit

let eventStore = EKEventStore()
var authorized = false
var events = [EKEvent]()

var calendars = [EKCalendar]()
var currentCalendar: EKCalendar?

func initEKCalenders(){
    calendars = eventStore.calendars(for: .event)
    if (calendars.count > 2) {
        currentCalendar = calendars[2]
    }
    
    checkCalendarAuthorizationStatus()
}

func checkCalendarAuthorizationStatus() {
    switch(EKEventStore.authorizationStatus(for: .event)) {
    case .notDetermined:
        print("not determined")
        requestAccessToCalendar()
    case .authorized:
        print("authorized")
        authorized = true
        retrieveEventsFromYesterdayThroughComingMonth()
    case .restricted, .denied:
        print("restricted or denied")
        requestAccessToCalendar()
    }
}

func requestAccessToCalendar() {
    eventStore.requestAccess(to: .event) {
        (accessGranted: Bool, error: Error?) in
        
        if (accessGranted) {
            DispatchQueue.main.async {
                print("Access calendars")
                authorized = true
                retrieveEventsFromYesterdayThroughComingMonth()
            }
        } else {
            DispatchQueue.main.async {
                print("Permission is required")
            }
        }
    }
}

func retrieveEventsFromYesterdayThroughComingMonth() {
    if (!authorized) {
        return
    }
    
    let calendar = Calendar.current
    
    let now = Date(timeIntervalSinceNow: 0)
    
    var oneDayAgoComponents = DateComponents()
    oneDayAgoComponents.day = -1
    
    var oneMonthFromNowComponents = DateComponents()
    oneMonthFromNowComponents.month = 1
    
    guard let startDate = calendar.date(byAdding: oneDayAgoComponents, to: now),
        let endDate = calendar.date(byAdding: oneMonthFromNowComponents, to: now) else {
            return
    }
    
    retrieveEvents(startDate: startDate, endDate: endDate)
}

func retrieveEvents(startDate: Date, endDate: Date) {
    let predicate = eventStore.predicateForEvents(withStart: startDate, end: endDate, calendars: nil)
    events = eventStore.events(matching: predicate)
}
