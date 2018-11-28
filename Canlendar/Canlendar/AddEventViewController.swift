//
//  AddEventViewController.swift
//  Canlendar
//
//  Created by KirtisOrendorff on 11/28/18.
//  Copyright © 2018 Ruicheng Peng. All rights reserved.
//

import UIKit
import EventKit

class AddEventViewController: UIViewController {

    @IBOutlet weak var titleTextBox: UITextField!
    @IBOutlet weak var descriptionTextBox: UITextField!
    @IBOutlet weak var confirmButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func confirmEvent(_ sender: UIButton) {
        guard let currentCalendar = currentCalendar else {
            //presentMessage(message: "No current calendar set on which to create event.")
            return
        }
        
        
        let startDate = Date(timeIntervalSinceNow: 0)
        var oneHourFromNowComponents = DateComponents()
        oneHourFromNowComponents.hour = 1
        
        guard let endDate = Calendar.current.date(byAdding: oneHourFromNowComponents, to: startDate) else {
            return
        }
        
        let event = EKEvent(eventStore: eventStore)
        
        event.calendar = currentCalendar
        event.title = titleTextBox.text
        event.startDate = startDate
        event.endDate = endDate
        event.notes = descriptionTextBox.text
        event.url = URL(string: "https://missouri.edu")
        
        do {
            try eventStore.save(event, span: .thisEvent)
            retrieveEventsFromYesterdayThroughComingMonth()
        } catch {
            //presentMessage(message: "Unable to save event in event store: \(error).")
        }
    }
}
