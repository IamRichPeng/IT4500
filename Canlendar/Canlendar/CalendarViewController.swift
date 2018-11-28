//
//  CalendarViewController.swift
//  Canlendar
//
//  Created by Ruicheng Peng on 11/20/18.
//  Copyright © 2018 Ruicheng Peng. All rights reserved.
//

import UIKit

class CalendarViewController: UIViewController ,UICollectionViewDelegate,UICollectionViewDataSource{

    
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
            
            
             currentMonth = Months[month]
            MonthLabel.text = "\(currentMonth)\(year)"
            Calendar.reloadData()
        default:
            Direction = 1
            
            
               month += 1
            
             currentMonth = Months[month]
            MonthLabel.text = "\(currentMonth)\(year)"
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
          
            
            currentMonth = Months[month]
            MonthLabel.text = "\(currentMonth)\(year)"
            Calendar.reloadData()
        default:
            month -= 1
            Direction = -1
            
            
             currentMonth = Months[month]
            MonthLabel.text = "\(currentMonth)\(year)"
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
    
    var PositionIndex = 0 // here we will store the above vars of the empty boxes
    
    var LeapYearCounter = year % 4
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initEKCalenders() //initializes events from user's Apple calendar, this allows us to push our new events into the user's default calender so they can also view our new events there.
        
        currentMonth = Months[month]
        
        MonthLabel.text = "\(currentMonth)\(year)"
        
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
        cell.backgroundColor = UIColor.clear
        
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
        switch indexPath.row{
        case 5,6,12,13,19,20,26,27,33,34:
            if Int(cell.DateButton.currentTitle!)! > 0{
                cell.DateButton.backgroundColor = UIColor.lightGray
            }
        default:
            break
        }
        
        // mark the cell showing the current date red
        if currentMonth == Months[calendar.component(.month, from: date) - 1] && year == calendar.component(.year, from: date) && indexPath.row + 1 == day{
            cell.backgroundColor = UIColor.red
        }
        
        return cell
    }
}
