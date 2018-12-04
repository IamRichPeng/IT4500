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

    @IBOutlet weak var datePickerLabel: UILabel!
    @IBOutlet weak var addAssignmentButton: UIBarButtonItem!
    @IBOutlet weak var titleTextBox: UITextField!
    @IBOutlet weak var descriptionTextBox: UITextField!
    
    @IBOutlet weak var taskLabel: UILabel!
    @IBOutlet weak var durationSliderValue: UISlider!
   
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    
    @IBOutlet weak var recurringSwitch: UISegmentedControl!
    
    @IBOutlet weak var minutesLabel: UILabel!
    
    @IBOutlet weak var minutesRequiredLabel: UILabel!
    @IBOutlet weak var confirmButton: UIBarButtonItem!
    
    @IBOutlet var backButton: UIView!
    
    @IBAction func addEventButton(_ sender: UIBarButtonItem) {
        taskLabel.text = "Event"
        titleTextBox.placeholder = "Title"
        descriptionTextBox.placeholder = "enter description"
       datePickerLabel.text = "Start Time"
        
    }
    
    @IBAction func addAssignmentButton(_ sender: UIBarButtonItem) {
        recurringSwitch.isHidden = true
        taskLabel.text = "Assignment"
        titleTextBox.placeholder = "Title:"
        descriptionTextBox.placeholder = "enter description here"
       datePickerLabel.text = "Due Date"
    }
    
    @IBAction func confirmButtonAction(_ sender: UIBarButtonItem) {
        guard let currentCalendar = currentCalendar else {
            //presentMessage(message: "No current calendar set on which to create event.")
            return
        }
        
        //variables to send to the Assignment Shuffler
        let dueDate = datePicker.date
        let duration = minutesLabel.text
        let assignmentTitle = titleTextBox.text
        
        
        //stuff for static event
        let startDate = datePicker.date
        var oneHourFromNowComponents = DateComponents()
        oneHourFromNowComponents.hour = 1
        
        guard let endDate = Calendar.current.date(byAdding: oneHourFromNowComponents, to: startDate) else {
            return
        }
        //end static event code
        
        let event = EKEvent(eventStore: eventStore)
        
        event.calendar = currentCalendar
        event.title = titleTextBox.text
        
        event.startDate = startDate
        event.endDate = endDate
        
        print(endDate)
        event.notes = descriptionTextBox.text
        event.url = URL(string: "https://missouri.edu")
        
        do {
            try eventStore.save(event, span: .thisEvent)
            retrieveEventsFromYesterdayThroughComingMonth()
        } catch {
            //presentMessage(message: "Unable to save event in event store: \(error).")
        }
        navigationController?.popViewController(animated: true)
    }
        
    
    
    @IBAction func durationSlider(_ sender: UISlider) {
        minutesLabel.text = String(Int(durationSliderValue.value/30)*30)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //addAssignmentButton(addAssignmentButton)
        taskLabel.textColor = UIColor.white
        minutesLabel.textColor = UIColor.white
        minutesRequiredLabel.textColor = UIColor.white
        descriptionTextBox.backgroundColor = UIColor(red:0.74, green:0.83, blue:0.96, alpha:1.0)
        titleTextBox.backgroundColor = UIColor(red:0.74, green:0.83, blue:0.96, alpha:1.0)
        recurringSwitch.tintColor = UIColor(red:0.74, green:0.83, blue:0.96, alpha:1.0)
        datePicker.backgroundColor = UIColor(red:0.57, green:0.72, blue:0.93, alpha:1.0)
        
        taskLabel.text = "Assignment"
        
        self.view.backgroundColor = UIColor(red:0.31, green:0.55, blue:0.89, alpha:1.0)
        minutesLabel.text = String(Int(durationSliderValue.value))
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

//the code needs to take the day it is due and pick a time between todays date and the due date and insert the activity into a time frame it would work in 
