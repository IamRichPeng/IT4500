//
//  CalendarViewController.swift
//  Canlendar
//
//  Created by Ruicheng Peng on 11/20/18.
//  Copyright © 2018 Ruicheng Peng. All rights reserved.
//

import UIKit
import EventKit

class CalendarViewController: UIViewController ,UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var EventDetailTableView: UITableView!
    @IBOutlet weak var MonthLabel: UILabel!
    
    
    
    @IBAction func Next(_ sender: Any) {
        switch currentMonth {
        case "December":
            month = 0
            year += 1
            Direction = 1
            
            if LeapYearCounter < 5{
                LeapYearCounter += 1
            }
            if LeapYearCounter == 4 {
                DaysInMonth[1] = 29
            }
            if LeapYearCounter == 5{
                LeapYearCounter = 1
                DaysInMonth[1] = 28
            }
            GetStartDayPosition()
            
            
             currentMonth = Months[month]
            MonthLabel.text = "\(currentMonth) \(year)"
            Calendar.reloadData()
        default:
            Direction = 1
            
           GetStartDayPosition()
               month += 1
            
             currentMonth = Months[month]
            MonthLabel.text = "\(currentMonth) \(year)"
            Calendar.reloadData()
        }
    }
    
    
    
    @IBAction func Back(_ sender: Any) {
        switch currentMonth {
        case "January":
            month = 11
            year -= 1
            Direction = -1
            
            if LeapYearCounter > 0{
                LeapYearCounter -= 1
            }
            if LeapYearCounter == 0 {
                DaysInMonth[1] = 29
                LeapYearCounter = 4
            }else{
                DaysInMonth[1] = 28
            }
          
            GetStartDayPosition()
            currentMonth = Months[month]
            MonthLabel.text = "\(currentMonth) \(year)"
            Calendar.reloadData()
        default:
            month -= 1
            Direction = -1
            GetStartDayPosition()
            
             currentMonth = Months[month]
            MonthLabel.text = "\(currentMonth) \(year)"
            Calendar.reloadData()
        }
    }
    
    @IBOutlet weak var Calendar: UICollectionView!
    
    let Months = ["January","February","March","April","May","June","July","August","September","October","November","December"]
    
    let DaysOfMonth = ["Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday"]
    
    var DaysInMonth = [31,28,31,30,31,30,31,31,30,31,30,31]
    
    var currentMonth = String()
    
    var NumberofEmptyBox = Int()  // The number of empty boxes at the start of the current month
    
    var NextNumberOfEmptyBox = Int()  //same as above
    
    var PreviousNumberOfEmptyBox = 0  //same as above
    
    var Direction = 0 // =0 if we are at the current month, =1 if we are in a future month, = -1 if we are in  a past month
    
    var PositionIndex = Int() // here we will store the above vars of the empty boxes
    
    var LeapYearCounter = year % 4
    
    var dayCounter = 0
    
    //for selecting a specific day's events
    var dailyEventList = [EKEvent]()
    let dateFormatter = DateFormatter()
    
    func GetStartDayPosition(){
        switch Direction{
        case 0:
            NumberofEmptyBox = weekday
            dayCounter = day
            while dayCounter > 0{
                NumberofEmptyBox = NumberofEmptyBox - 1
                dayCounter = dayCounter - 1
                if NumberofEmptyBox == 0{
                    NumberofEmptyBox = 7
                }
            }
            if NumberofEmptyBox == 7{
                NumberofEmptyBox = 0
            }
            PositionIndex = NumberofEmptyBox
        case 1...:
            NextNumberOfEmptyBox = (PositionIndex + DaysInMonth[month])%7
            PositionIndex = NextNumberOfEmptyBox
        case -1:
            PreviousNumberOfEmptyBox = (7 - (DaysInMonth[month] - PositionIndex)%7)
            if PreviousNumberOfEmptyBox == 7 {
                PreviousNumberOfEmptyBox = 0
            }
            PositionIndex = PreviousNumberOfEmptyBox
        default:
            fatalError()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        
        EventDetailTableView.delegate = self
        EventDetailTableView.dataSource = self
        
        initEKCalenders() //initializes events from user's Apple calendar, this allows us to push our new events into the user's default calender so they can also view our new events there.
        
        currentMonth = Months[month]
        
        MonthLabel.text = "\(currentMonth) \(year)"
        
        if weekday == 0{
            weekday = 7
        }
        GetStartDayPosition()
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch Direction{            //it returns the number of days in the month + the number of "empty boxes" based on the direction we are going
        case 0:
            return DaysInMonth[month] + NumberofEmptyBox
        case 1...:
            return DaysInMonth[month] + NextNumberOfEmptyBox
        case -1:
            return DaysInMonth[month] + PreviousNumberOfEmptyBox
        default:
            fatalError()
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Calendar", for: indexPath) as! DateCollectionViewCell
        cell.DateButton.backgroundColor = UIColor.clear
        
        if cell.isHidden{
            cell.isHidden = false
        }
      
        switch Direction{
        case 0:
            cell.DateButton.setTitle("\(indexPath.row + 1 - NumberofEmptyBox)", for: .normal)
        case 1...:
            cell.DateButton.setTitle("\(indexPath.row + 1 - NextNumberOfEmptyBox)", for: .normal)
        case -1:
            cell.DateButton.setTitle("\(indexPath.row + 1 - PreviousNumberOfEmptyBox)", for: .normal)
        default:
            fatalError()
        }
        
        if Int(cell.DateButton.currentTitle!)! < 1{// hides every cell that is smaller than 1
            cell.isHidden = true
        }
        
         //show the weekend in different color
        //TODO TODO TODO we need to not hardcode this, the weekends arent gonna work in different months
        switch indexPath.row{
        case 5,6,12,13,19,20,26,27,33,34:
            if Int(cell.DateButton.currentTitle!)! > 0{
                cell.DateButton.backgroundColor = UIColor.lightGray
            }
        default:
            break
        }
        
        // mark the cell showing the current date red
        if currentMonth == Months[calendar.component(.month, from: date) - 1] && year == calendar.component(.year, from: date) && indexPath.row + 1 == day + NumberofEmptyBox{
            cell.DateButton.backgroundColor = UIColor.red
        }
        
        //this links the button to an IBAction we can use here so we can fetch that button's date
        cell.DateButton.tag = indexPath.row
        cell.DateButton.addTarget(self,
                              action: #selector(self.selectDate),
                              for: .touchUpInside)
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dailyEventList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath)

        print("yes")
        if let cell = cell as? EventDetailTableViewCell{
            dateFormatter.dateFormat = ("h:mm a")
            cell.EventDescriptionLabel.text = dailyEventList[indexPath.row].title
            cell.TimeLabel.text = dateFormatter.string(for: dailyEventList[indexPath.row].startDate)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let destination = ExpandedEventViewController()
        performSegue(withIdentifier: "ExpandEventSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ExpandEventSegue"{
            if let destination = segue.destination as? ExpandedEventViewController,
                let row = EventDetailTableView.indexPathForSelectedRow?.row{
                
                destination.event = dailyEventList[row]
                
            }
        }
    }
    
    @IBAction func selectDate(_ sender: UIButton) {
        var currentDateString: String
        dailyEventList.removeAll()
    
        dateFormatter.dateFormat = ("d MMMM yyyy")
        
        //create a way to read the selected day
        currentDateString = sender.currentTitle! + " " + MonthLabel.text!
        var currentDate = dateFormatter.date(from: currentDateString)
        
        //pulls all EKEvents that share same date as currentDate
        for event in events{
            if calendar.compare(event.startDate, to: currentDate!, toGranularity: .day) == ComparisonResult.orderedSame{
                dailyEventList.insert(event, at: 0)
            }
        }
        print(dailyEventList)
        
        //the UI will NOT. FUCKING. REFRESH.
        refreshUI()
        //EventDetailTableView.reloadData()
    }
    
    func refreshUI() {
        DispatchQueue.main.async( execute: { self.EventDetailTableView.reloadData() });
    }
}
